# Hough Line Transform from Scratch using Python

This project implements the **Hough Line Transform** from scratch using **Python**, **NumPy**, and **OpenCV**. The algorithm detects straight lines in an image by transforming edge pixels into the Hough parameter space and identifying the accumulator peaks.

---

# 📌 Features

- Edge detection using the Canny algorithm
- Manual implementation of the Hough Line Transform
- Construction of the Hough accumulator (parameter space)
- Peak detection using a voting threshold
- Line reconstruction from Hough parameters
- Visualization of:
  - Edge image
  - Hough accumulator (Heatmap)
  - Final detected lines

---

# 📂 Project Structure

```
Machine_Vision/
│
├── input.png
├── hough_line.ipynb
└── README.md
```

---

# 🛠 Requirements

Install the required Python libraries:

```bash
pip install numpy opencv-python matplotlib
```

---

# 📚 Libraries Used

- NumPy
- OpenCV
- Matplotlib

---

# Algorithm Overview

The implementation follows the classical Hough Transform pipeline:

1. Read the grayscale image.
2. Detect edges using the Canny edge detector.
3. Build the Hough accumulator.
4. Vote for every possible line passing through each edge pixel.
5. Detect accumulator peaks.
6. Convert detected peaks back to image-space lines.
7. Draw the detected lines on the original image.

---

# Step 1 — Edge Detection

The input image is converted into an edge map using:

```python
cv2.Canny(image, 50, 150)
```

The resulting binary image contains the edge pixels used by the Hough Transform.

---

# Step 2 — Hough Parameter Space

Each image point is represented in the Hough space using:

```
ρ = x cos(θ) + y sin(θ)
```

where:

- **ρ** is the perpendicular distance from the origin.
- **θ** is the angle of the line.

The parameter ranges used are:

| Parameter | Range |
|-----------|-------|
| θ | -90° to 89° |
| ρ | -Diagonal Length to +Diagonal Length |

---

# Step 3 — Accumulator Voting

For every detected edge pixel:

- Iterate through all θ values.
- Compute the corresponding ρ.
- Increment the corresponding accumulator cell.

The accumulator stores the number of votes for each possible line.

---

# Step 4 — Peak Detection

The strongest lines are detected by selecting accumulator cells whose vote count exceeds:

```python
threshold = accumulator.max() * 0.5
```

These cells represent the most likely lines in the image.

---

# Step 5 — Line Reconstruction

Each detected pair (ρ, θ) is converted back into a line in image space.

The endpoints are computed using:

```python
x0 = ρ cos(θ)
y0 = ρ sin(θ)
```

Two distant points are then generated so the line spans the entire image before being drawn with OpenCV.

---

# Output

The program displays three visualizations:

### 1. Edge Image

Shows the edges detected by the Canny algorithm.

---

### 2. Hough Accumulator (Heatmap)

A visualization of the voting space.

Bright regions indicate strong line candidates with many votes.

---

### 3. Final Image

The detected lines are drawn on the original image.

---

# Input

```
input.png
```

Any grayscale image containing straight lines can be used as input.

---

# Concepts Covered

- Edge Detection
- Canny Algorithm
- Hough Transform
- Polar Coordinate Representation
- Voting-Based Detection
- Accumulator Array
- Peak Detection
- Computer Vision
- Image Processing

---

# Results

This project demonstrates how the Hough Transform detects straight lines by:

- Converting image points into parameter space.
- Accumulating votes for possible lines.
- Identifying peaks in the accumulator.
- Reconstructing the detected lines in the original image.

The implementation is written from scratch, providing a clear understanding of the Hough Line Transform without relying on OpenCV's built-in Hough functions.
