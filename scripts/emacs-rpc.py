from pypresence import Presence
import time
import sys
import os

print("loaded presence script successfully!")

APP_ID = "1405641964157927496"
DEBUG = False

rpc = Presence(APP_ID)

print("trying to connect to rpc server")

while True:
	try:
		rpc.connect()
		print("successfully connected to rpc server")
		break
	except:
		time.sleep(10)
		continue

start_time = time.time()

modes = {
	"c": "c-mode",
	"h": "c-mode",
	"cpp": "cpp-mode",
	"cs": "csharp-mode",
	"el": "elisp-mode",
	"py": "python-mode",
	"sh": "shell-mode",
	"bash": "shell-mode"
}

def get_mode(filename):
	parts = filename.rsplit(".", 1)
	if len(parts) < 2:
		return "text-mode"
	ext = parts[1]
	return modes.get(ext, "text-mode");

rpc.update(
	state="e-maxxing",
	start=start_time
)

for line in sys.stdin:
	line = line.strip()
	if not line:
		continue
	if line == "!debug-on":
		DEBUG = True
	if line == "!debug-off":
		DEBUG = False

	# format: "filename:line"
	try:
		filepath, lineno = line.split(":", 1)
		filename = os.path.basename(filepath)
	except:
		filename, lineno = line, "?"

	mode = "?"
	if line != "?":
		mode = get_mode(filename)

	if DEBUG:
		print(f"updating to {filename}:{lineno} and mode {mode}")

	rpc.update(
		details=f"e-maxxing '{filename}'",
		state=f"on line: {lineno}",
		small_image=mode,
		small_text="small_text",
		join="https://www.salek.uk",
		spectate="https://www.salek.uk",
		start=start_time
	)
