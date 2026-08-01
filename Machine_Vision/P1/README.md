# Image Enhancement Techniques using Python & OpenCV

This project implements and compares several classical image enhancement techniques using **Python**, **NumPy**, **OpenCV**, and **Matplotlib**.

The project contains three main parts:

1. Histogram Equalization (Manual Implementation)
2. Contrast Limited Adaptive Histogram Equalization (CLAHE)
3. Local Image Enhancement using Local Statistics

---

# 📌 Features

- Manual implementation of Histogram Equalization
- Comparison with OpenCV's built-in `equalizeHist()`
- CLAHE with different clip limits
- Local enhancement based on neighborhood statistics
- Histogram visualization for all results
- Side-by-side comparison of enhancement techniques

---

# 📂 Project Structure

```
Machine_Vision/
│
├── 1.jpg
├── 2.jpg
├── fig3-27.jpg
├── cv-project_final.ipynb
└── README.md
```

---

# 🛠 Requirements

Install the required libraries:

```bash
pip install numpy opencv-python matplotlib
```

---

# 📚 Libraries Used

- NumPy
- OpenCV
- Matplotlib

---

# Part 1 — Histogram Equalization

## Objective

Improve image contrast by redistributing gray-level intensities over the full intensity range.

---

## Manual Implementation

The function

```python
HistogramEqualize(img)
```

performs the following steps:

1. Compute the histogram.
2. Compute the cumulative distribution function (CDF).
3. Normalize the CDF.
4. Map every pixel using the normalized CDF.
5. Generate the enhanced image.

---

## Comparison

The result is compared with

```python
cv2.equalizeHist()
```

The following are displayed:

- Original Image
- Manual Histogram Equalization
- OpenCV Histogram Equalization
- Original Histogram
- Manual Histogram
- OpenCV Histogram

---

# Part 2 — CLAHE

## Objective

Avoid over-enhancement and noise amplification produced by global histogram equalization.

The project compares:

| Method | Clip Limit |
|---------|-----------|
| CLAHE | 1.0 |
| CLAHE | 3.0 |
| CLAHE | 5.0 |
| Normal Histogram Equalization | — |

Each result is displayed together with its histogram.

---

## Parameters

### clipLimit

Controls the amount of contrast enhancement.

Lower value

- Less enhancement
- Less noise amplification

Higher value

- Stronger contrast
- More visible local details
- Possible increase in noise

---

### tileGridSize

The image is divided into small blocks:

```
8 × 8
```

Each block is equalized independently.

---

# Part 3 — Local Image Enhancement

## Objective

Enhance only dark, low-contrast regions while preserving the rest of the image.

Unlike Histogram Equalization, enhancement is performed locally.

---

## Algorithm

For every pixel:

1. Extract a local window.
2. Compute

- Local Mean
- Local Standard Deviation

3. Compare them with global statistics.

If

```
Local Mean ≤ K0 × Global Mean
```

and

```
Local Std ≤ K1 × Global Std
```

the pixel intensity is multiplied by

```
C
```

Otherwise the pixel remains unchanged.

---

## Tested Parameters

| Window Size | C | K0 | K1 |
|-------------|----|----|----|
| 3 | 1.5 | 0.3 | 0.10 |
| 5 | 2.0 | 0.4 | 0.15 |
| 7 | 2.5 | 0.5 | 0.20 |
| 9 | 3.0 | 0.6 | 0.25 |

---

# Output

The notebook visualizes:

- Original image
- Enhanced images
- Histograms
- Comparison between methods

---

# Input Images

| Image | Purpose |
|--------|---------|
| 1.jpg | Histogram Equalization |
| 2.jpg | CLAHE |
| fig3-27.jpg | Local Enhancement |

---

# Concepts Covered

- Image Histogram
- Cumulative Distribution Function (CDF)
- Histogram Equalization
- Adaptive Histogram Equalization
- CLAHE
- Local Image Statistics
- Contrast Enhancement
- Image Processing

---

# Results

The project demonstrates the differences between:

- Manual Histogram Equalization
- OpenCV Histogram Equalization
- CLAHE with different clip limits
- Local Enhancement based on statistical measures

allowing visual comparison of contrast improvement and histogram redistribution.

