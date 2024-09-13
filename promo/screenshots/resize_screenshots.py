from PIL import Image
import os

# Define a function to handle conversion with profile preservation
def convert_with_profile(png_file, jpg_file, quality=70):
    # Open the PNG image with its profile
    img = Image.open(png_file)
    profile = img.info.get("icc_profile")

    # Convert to RGB if necessary
    if img.mode != "RGB":
        img = img.convert("RGB")

    # Save as JPG with specified quality and embedded profile (if available)
    img.save(jpg_file, quality=quality, icc_profile=profile)

# Iterate through all files in the current directory
for filename in os.listdir():
    if filename.endswith(".png"):
        # Extract file names without extensions
        base_name, _ = os.path.splitext(filename)
        jpg_file = f"{base_name}.jpg"

        # Call conversion function with desired quality
        convert_with_profile(filename, jpg_file)
        print(f"Converted {filename} to JPG with profile (if present)")

