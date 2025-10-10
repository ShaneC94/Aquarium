# Virtual Aquarium Project

This project is an **interactive virtual aquarium** built in **Processing 4.x**.  
It simulates a realistic underwater environment featuring animated fish, ambient sound, and responsive user interactions.

---

## Features

- **15+ animated fish** that swim independently using random movement and wall avoidance  
- **Click to drop food** that fish actively chase  
- **Predator mode:** fish avoid the mouse cursor to simulate a predator effect  
- **Day/Night toggle** with smooth lighting and background transitions  
- **Ambient underwater soundscape** using the Processing Sound library  
- **Environmental animations:** bubbles, swaying seaweed, coral base, and dynamic background lighting  
- **Heads-Up Display (HUD)** showing live stats, controls, and current aquarium status  

---

## How to Run

1. Open the **Processing IDE (version 4.x)**  
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
This version was exported using Processing 4.x for Windows (64-bit).  
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

- Built using **Processing 4.x** and the **Processing Sound library**  
- Modular, object-oriented design with multiple `.pde` classes (`Fish`, `Food`, `Bubble`, `Seaweed`, `CoralBase`)  
- Uses **ArrayList** structures for dynamic fish and object management  
- Demonstrates **animation loops, event handling, and simple AI behavior**  
- Designed for smooth performance and interactivity  

---

## Assets and Licensing

All images and sound assets used in this project are **free for personal and educational use**.  
They are included under non-commercial licenses and used solely for academic demonstration purposes within this course project.

---

## Author

**Shane Currie**  
Ontario Tech University  
*SOFE 4640U – User Experience Design (Fall 2025)*

---

© 2025 Shane Currie — For educational and personal use only.
