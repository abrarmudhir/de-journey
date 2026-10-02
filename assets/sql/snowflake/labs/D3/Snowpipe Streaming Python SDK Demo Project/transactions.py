"""
Simulates a continuous stream of transactions into Snowflake
using the Snowpipe Streaming SDK — 10 transactions per minute forever.
The channel is kept open and reused across iterations.
"""

from datetime import datetime
import time
import uuid
import os
import random

os.environ["SS_LOG_LEVEL"] = "warn"

from snowflake.ingest.streaming import StreamingIngestClient

DATABASE = "TRANSACTIONS_DB"
SCHEMA = "TRANSACTIONS_SCHEMA"
TABLE = "TRANSACTIONS"
PIPE = f"{TABLE}-STREAMING"

# 10 transactions per minute = 1 every 6 seconds
INTERVAL_SECONDS = 6

MERCHANTS = [
    "Amazon",
    "Tesco",
    "Uber",
    "Netflix",
    "Deliveroo",
    "Apple",
    "ASOS",
    "Spotify",
]
CURRENCIES = ["GBP", "USD", "EUR"]
STATUSES = ["approved", "approved", "approved", "declined", "pending"]  # weighted


def make_transaction(seq: int) -> dict:
    return {
        "transaction_id": str(uuid.uuid4()),
        "sequence": seq,
        "merchant": random.choice(MERCHANTS),
        "amount": round(random.uniform(1.0, 500.0), 2),
        "currency": random.choice(CURRENCIES),
        "status": random.choice(STATUSES),
        "ts": datetime.utcnow(),
    }


def main():
    print(f"Starting transaction stream — {60 // INTERVAL_SECONDS} tx/min")
    print("Press Ctrl+C to stop.\n")

    # Use a stable channel name so offset is preserved across restarts
    channel_name = "TRANSACTIONS_SIMULATOR"

    with StreamingIngestClient(
        client_name=f"TX_SIM_{uuid.uuid4()}",
        db_name=DATABASE,
        schema_name=SCHEMA,
        pipe_name=PIPE,
        profile_json="profile.json",
    ) as client:

        channel, status = client.open_channel(channel_name)
        last_offset = status.latest_committed_offset_token
        seq = int(last_offset) + 1 if last_offset is not None else 0

        print(f"Channel '{channel_name}' opened. Resuming from sequence {seq}.\n")

        with channel:
            while True:
                tx = make_transaction(seq)

                channel.append_row(tx, str(seq))

                print(
                    f"[{tx['ts'].strftime('%H:%M:%S')}] "
                    f"seq={seq:>6}  {tx['merchant']:<12} "
                    f"{tx['currency']} {tx['amount']:>7.2f}  {tx['status']}"
                )

                seq += 1
                time.sleep(INTERVAL_SECONDS)


if __name__ == "__main__":
    main()
