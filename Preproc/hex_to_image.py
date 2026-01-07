import numpy as np
from PIL import Image

# Update this path to where your file actually is
INPUT_HEX   = r"C:\Users\Hirthick\Desktop\Preprocessing\processed_image.txt"
OUTPUT_PNG  = r"C:\Users\Hirthick\Desktop\Preprocessing\final_result.png"

WIDTH       = 1280
HEIGHT      = 720

def main():
    try:
        print(f"Reading {INPUT_HEX}...")
        with open(INPUT_HEX, 'r') as f:
            lines = f.readlines()
            
        pixels = []
        for line in lines:
            line = line.strip()
            if line:
                # --- FIX: Handle 'xx' values from Verilog ---
                if "x" in line.lower() or "z" in line.lower():
                    pixels.append(0) # Treat undefined as black
                else:
                    pixels.append(int(line, 16))
                # --------------------------------------------
        
        # Verify size
        if len(pixels) != WIDTH * HEIGHT:
            print(f"Warning: Expected {WIDTH*HEIGHT} pixels, got {len(pixels)}")
            # Pad with zeros if short, or trim if too long
            if len(pixels) < WIDTH * HEIGHT:
                pixels += [0] * (WIDTH * HEIGHT - len(pixels))
            else:
                pixels = pixels[:WIDTH * HEIGHT]
            
        # Reshape and Save
        arr = np.array(pixels, dtype=np.uint8).reshape((HEIGHT, WIDTH))
        img = Image.fromarray(arr, 'L')
        img.save(OUTPUT_PNG)
        img.show()
        print(f"Success! Saved to {OUTPUT_PNG}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()