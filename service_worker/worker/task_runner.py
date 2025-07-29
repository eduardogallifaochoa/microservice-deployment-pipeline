import time

def run_worker():
    print("Worker started, processing tasks...")
    while True:
        print("Worker is processing tasks...")
        time.sleep(5)  # Simulate task processing

if __name__ == "__main__":
    run_worker()
