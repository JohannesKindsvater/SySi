# 📘 Signals & Systems Work Template ✨

A clean and customizable **Typst** template for work in the **Signals & Systems** course with **Prof. Gröll**.

## 🚀 Overview

This template helps you create consistent, well-formatted homework submissions using [Typst](https://typst.app/). It supports automatic inclusion of course details, easy chapter management, and seamless math and code formatting.

## ⚙️ Setup

### 🧍Configure Your Personal Information

Edit the `.env` file and add your matriculation number:

```env
MATRICULATION_NUMBER="YOUR_NUMBER_HERE"
```

This value will be automatically included in your document title page.

### 🏫 Set Course Information

In your `main.typ` file, configure the course and system parameters in the `#work()` block:

```typst
#work(
  course: "TINFXXBX",
  system: "Your System",
)
```

## ✏️ Usage

### 🧮 Mathematical Expressions

Use `$...$` for inline math:

```typst
The transfer function is $H(s) = 1 / (s + 1)$.
```

Output: The transfer function is $H(s) = \frac{1}{s + 1}$.

Display mode:

```typst
$
H(s) = \frac{1}{s + 1}
$
```

### 💻 Code Snippets

Include inline MATLAB commands with backticks:

```typst
Use `disp('Hello World')` to print output.
```

For larger code blocks, use fenced code blocks:

```matlab
t = 0:0.01:10;
y = exp(-t);
plot(t, y);
```

### 📂 Adding New Chapters

To organize your work across multiple files:

1. Create a new file in the `chapters/` folder, e.g. `chapters/chapter1.typ`.

2. Add it to the `#include-chapters-with-break()` list in your main document:

```typst
#include-chapters-with-break(
  "chapters/chapter1.typ",
  "chapters/chapter2.typ",
  // Add more chapters as needed
)
```

Each chapter will automatically begin on a new page. ✅

### 🧰 Compilation

To build your document, run:

```bash
typst compile main.typ
```

Or to automatically recompile on changes:

```bash
typst watch main.typ
```

### 🧩 Requirements

🧱 **Typst** ≥ 0.11.0

Download from [typst.app](https://typst.app/) or install via brew.

```bash
brew install typst
```

kindsvater leck eier

### 📄 License

This template is provided as-is for educational purposes.
You are free to modify and distribute it within the scope of your coursework.

Made with ❤️ for Signals & Systems students.
