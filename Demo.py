# print hello world (from Manaf at IDUN along with the date and time)

from datetime import datetime

def main():
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"Hello World! This message is from Manaf at IDUN. Current date and time: {current_time}")

if __name__ == "__main__":
    main()
