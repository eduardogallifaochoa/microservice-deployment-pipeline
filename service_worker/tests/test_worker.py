import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from worker.task_runner import run_worker


def test_worker_exists():
    assert callable(run_worker)
