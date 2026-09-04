# Virtual Aquarium Project

This project is an **interactive virtual aquarium** built in **Processing 4**.  
It simulates a realistic underwater environment featuring animated fish, ambient sound, and responsive user interactions.

---

## Features

- **15+ animated fish** that swim independently using random movement and wall avoidance  
- **Click to drop food** that fish actively chase  
- **Predator mode:** fish avoid the mouse cursor to simulate a predator effect  
- **Day/Night toggle** with smooth background transitions  
- **Ambient underwater soundscape** using the Processing Sound library  
- **Environmental animations:** bubbles, swaying seaweed, and coral base  
- **Heads-Up Display (HUD)** showing live stats, controls, and current aquarium status  

---

## How to Run

1. Open the **Processing IDE (version 4)**  
2. Load the `VirtualAquarium.pde` file  
3. Ensure the `/data` folder (with images and sound files) is in the same directory as your `.pde` files  
4. Click **Run (▶)** to start the aquarium simulation  

---

## How to Run (Executable Windows Build)

If you prefer to run the standalone version instead of using Processing:

1. Go to the **[Releases](../../releases)** section of this repository.  
2. Download the file named **`Virtual_Aquarium_Windows.zip`**.  
3. Extract the zip file to any folder on your computer.  
4. Open the extracted folder — it should contain:

```bash
VirtualAquarium/
   ├─ data/
   ├─ java/
   ├─ lib/
   ├─ source/
   └─ VirtualAquarium.exe
```

5. Double-click **`VirtualAquarium.exe`** (or just **`VirtualAquarium`** if file extensions are hidden).  
6. The aquarium will launch in its own window — no Processing IDE required.

**Note:**  
This version was exported using Processing 4 for Windows (64-bit).  
It includes all necessary libraries and a lightweight Java runtime.

---

## Controls

| Key | Action |
|-----|--------|
| **Mouse Click** | Drop food for fish |
| **F** | Drop food for fish where mouse is positioned |
| **N** | Toggle day/night mode |
| **P** | Toggle predator mode |
| **R** | Reset aquarium |

---

## Example Output

**Aquarium at program start:**  
<img width="1841" height="889" alt="virtual_aquarium_screenshot_start" src="https://github.com/user-attachments/assets/e7bf4abe-55f3-4797-af53-12d363b9c641" />

**Aquarium switched to night-mode:**
<img width="1843" height="886" alt="virtual_aquarium_night_mode" src="https://github.com/user-attachments/assets/c41ccb56-4039-481d-a096-90ecb11b4cc1" />

**Fish with low constitution** take on a duller color and move slower:  
<img width="1838" height="890" alt="virtual_aquarium_screenshot_low_constitution" src="https://github.com/user-attachments/assets/b31ac10d-b6ed-4ac6-9b87-6639c6abc58c" />

**Fish with extremely low or no constitution** take on a darker tone and show further reduced movement:  
<img width="1840" height="892" alt="virtual_aquarium_screenshot_low_to_no_constitution" src="https://github.com/user-attachments/assets/9139fc86-487e-41f0-a15f-f6b2b2431966" />

**Fish being fed** – regaining constitution, color, and speed:  
<img width="1843" height="891" alt="virtual_aquarium_screenshot_food" src="https://github.com/user-attachments/assets/f7eb872d-0964-4ef5-9f8a-13b741d36a44" />

**Fish exhibiting food-seeking behavior:**  
<img width="1845" height="890" alt="virtual_aquarium_screenshot_food_seeking_behavior" src="https://github.com/user-attachments/assets/55a75508-2005-4683-a80a-9267bfbbf6c5" />

---

## Video Demo

Demonstrates **predator avoidance**, **random wandering**, **food-seeking behavior**, and **depth-sorting**.  
Also showcases the **day/night transition** and **aquarium reset** functionality.

https://github.com/user-attachments/assets/c5d97e26-122a-495a-bd3a-14d346edb189

---

## Implementation Details

- Built using **Processing 4** and the **Processing Sound library**  
- Modular, object-oriented design with multiple `.pde` classes (`Fish`, `Food`, `Bubble`, `Seaweed`, `CoralBase`)  
- Uses **ArrayList** structures for dynamic fish and object management  
- Demonstrates **animation loops, event handling, and simple AI behavior**  
- Designed for smooth performance and interactivity  

---

## Frequently Asked Questions

### Do I need Processing installed to run the aquarium?

No. You can either run the project through **Processing 4** or use the standalone Windows build available in the **Releases** section.

The standalone version includes the required Java runtime and does not require the Processing IDE.

### Which version of Processing should I use?

The project was developed using **Processing 4**. Older versions of Processing may cause compatibility issues.

### Does the project require any additional libraries?

Yes. When running the project through the Processing IDE, the **Processing Sound library** must be installed.

To install it:

1. Open Processing 4  
2. Go to **Sketch → Import Library → Manage Libraries**  
3. Search for **Sound**  
4. Install the Processing Sound library  

### Where should the `data` folder be located?

The `data` folder must remain in the same project directory as the `.pde` files.

Example:

```bash
VirtualAquarium/
   ├─ VirtualAquarium.pde
   ├─ Fish.pde
   ├─ Food.pde
   ├─ Bubble.pde
   ├─ Seaweed.pde
   ├─ CoralBase.pde
   └─ data/
```

Moving or renaming the `data` folder may prevent images or sound files from loading correctly.

### Can I run the standalone build on macOS or Linux?

The provided executable build was exported for **64-bit Windows**.

The source code can still be opened and run using Processing 4 on other supported operating systems.

### What does predator mode do?

Predator mode causes the fish to avoid the mouse cursor as if it were a predator.

Press **P** to turn predator mode on or off.

### Why do some fish become darker or move slower?

Fish have a constitution value that affects their appearance and movement.

As constitution decreases, fish become duller or darker and move more slowly. Feeding the fish restores constitution, color, and speed.

### How do I reset the aquarium?

Press **R** at any time to reset the aquarium to its initial state.

---

## Troubleshooting

### The application does not start in Processing

Check the following:

1. You are using **Processing 4**  
2. `VirtualAquarium.pde` is opened from the complete project folder  
3. All required `.pde` files are present  
4. The `data` folder is inside the project directory  
5. The Processing Sound library is installed  

If you recently installed the Sound library, restart Processing before running the application again.

### Processing reports that the Sound library cannot be found

Install the Processing Sound library through:

**Sketch → Import Library → Manage Libraries**

Search for **Sound**, install the library, restart Processing, and run the application again.

### Images, fish sprites, or other visual assets are missing

Verify that the `data` folder has not been deleted, renamed, or moved.

The `data` folder must remain inside the aquarium project directory so Processing can locate the required assets.

### There is no underwater audio

Check that:

- The Processing Sound library is installed  
- The required sound files are present in the `data` folder  
- Your system audio is not muted  
- The correct playback device is selected  

If running through Processing, restart the sketch after confirming the library and audio files are available.

### The Windows executable does not launch

Make sure the entire ZIP archive has been extracted before running the program.

Do not run `VirtualAquarium.exe` directly from inside the ZIP archive.

The extracted folder should contain:

```bash
VirtualAquarium/
   ├─ data/
   ├─ java/
   ├─ lib/
   ├─ source/
   └─ VirtualAquarium.exe
```

The executable depends on the other files included in this directory.

### The executable opens but images or sounds are missing

Do not move `VirtualAquarium.exe` out of the exported directory.

The executable relies on the accompanying `data`, `java`, `lib`, and other exported folders.

If any files are missing, extract a fresh copy of `Virtual_Aquarium_Windows.zip`.

### Keyboard controls are not responding

Click inside the aquarium window first to ensure it has keyboard focus.

Then try the appropriate control again:

| Key | Action |
|-----|--------|
| **F** | Drop food |
| **N** | Toggle day/night mode |
| **P** | Toggle predator mode |
| **R** | Reset aquarium |

### The aquarium behaves unexpectedly after changing modes

Press **R** to reset the aquarium to its initial state.

This can be useful after experimenting with predator mode, feeding, or other interactive features.

---

## Assets and Licensing

All images and sound assets used in this project are **free for personal and educational use**.  
They are included under non-commercial licenses and used solely for academic demonstration purposes within this course project.

---
