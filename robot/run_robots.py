import os
import subprocess
import glob

test_suites = glob.glob("*.robot")
for suite in test_suites:
    suite_name = os.path.splitext(os.path.basename(suite))[0]
    output_dir = f"results/{suite_name}"
    subprocess.run(["robot", "-d", output_dir, suite])
