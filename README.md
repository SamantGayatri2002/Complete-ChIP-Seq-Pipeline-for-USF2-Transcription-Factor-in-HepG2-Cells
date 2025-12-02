# Complete-ChIP-Seq-Pipeline-for-USF2-Transcription-Factor-in-HepG2-Cells

![ChIP-Seq](https://img.shields.io/badge/Workflow-ChIP--Seq-blueviolet)
![TF: USF2](https://img.shields.io/badge/Target-USF2-orange)
![Genome hg38](https://img.shields.io/badge/Genome-hg38-green)
![GSE104247](https://img.shields.io/badge/GEO-GSE104247-lightgrey)
![SRA](https://img.shields.io/badge/SRA-SRR6117703_|_SRR6117732-blue)
![HOMER](https://img.shields.io/badge/Peak_Calling-HOMER-red)
![deepTools](https://img.shields.io/badge/Visualization-deepTools-purple)
![Reproducible](https://img.shields.io/badge/Reproducible-Yes-brightgreen)
![Conda Env](https://img.shields.io/badge/Environment-conda-yellowgreen)
![WSL2 Ubuntu](https://img.shields.io/badge/Platform-WSL2_|_Ubuntu_24.04-blue)
![Python](https://img.shields.io/badge/Python-3.10-yellow)



## 🧭 **Project Summary**

Chromatin Immunoprecipitation followed by sequencing (ChIP-Seq) enables genome-wide mapping of protein–DNA interactions.
This repository provides a **fully reproducible ChIP-Seq analysis pipeline** for the transcription factor **USF2** in **HepG2** cells, leveraging raw sequencing data from **GSE104247**.
All analyses—including alignment, peak calling, motif discovery, GREAT enrichment, and visualization—were performed once, and the entire workflow is made reproducible through a preserved **conda environment**, standardized folder structure, and documented scripts.

---

## 📘 **This pipeline maily follows the below steps**

```
               ┌───────────────┐
               │   Raw Data    │
               │  (SRA → FASTQ)│
               └───────┬───────┘
                       │
               ┌───────▼───────┐
               │   Trimming    │ (Trim Galore)
               └───────┬───────┘
                       │
               ┌───────▼───────┐
               │   Alignment   │ (BWA-MEM to hg38)
               └───────┬───────┘
                       │
          ┌────────────▼────────────┐
          │    BAM Processing       │
          │ sorting • dedup • filter│
          │ blacklist removal       │
          └────────────┬────────────┘
                       │
               ┌───────▼───────┐
               │  Peak Calling │ (HOMER)
               └───────┬───────┘
                       │
        ┌──────────────▼──────────────┐
        │  Motif Analysis (HOMER)     │
        └──────────────┬──────────────┘
                       │
        ┌──────────────▼──────────────┐
        │  Functional Enrichment      │ (GREAT)
        └──────────────┬──────────────┘
                       │
       ┌───────────────▼────────────────┐
       │  deepTools Visualization       │
       │ bigWigs • heatmap • profile    │
       └────────────────────────────────┘


```


---

# 📁 **Repository Structure**

```
ChIP-Seq-USF2-Analysis/
│
├── raw/                         # FASTQ files downloaded from SRA
├── trim/                        # Trim Galore + FastQC outputs
│
├── bam/                         # Alignment, sorted BAMs, peaks, annotation
│   ├── USF2_clean.bam
│   ├── INPUT_clean.bam
│   ├── USF2_peaks.bed
│   ├── USF2_peak_annotation.txt
│   └── USF2_summits_200bp.bed
│
├── motifs_USF2/                 # HOMER motif output (logos, PWM, HTML reports)
│
├── great/                       # GREAT 200bp summit-centered regions + results
│
├── visualization/               # bigWigs, heatmap, profile plots
│   ├── USF2.bw
│   ├── INPUT.bw
│   ├── USF2_vs_INPUT_log2.bw
│   ├── USF2_heatmap.png
│   └── USF2_profile.png
│
├── scripts/                     # All pipeline scripts (optional for re-running)
│   ├── chipseq_visualization_full.sh
│   └── stage-wise scripts
│
├── environment.yml              # Exported exact conda environment (reproducibility)
│
├── docs/                        # Workflow diagrams / PDF reports (optional)
│
└── README.md
```

---

# 🌐 **Dataset Information**

* **GEO Series:** GSE104247
* **ChIP Sample:** SRR6117703 (USF2 IP)
* **Input Control:** SRR6117732
* **Organism:** *Homo sapiens*
* **Cell Line:** HepG2
* **Platform:** Illumina HiSeq 2000
* **Assay:** ChIP-Seq (TF binding profiling)

---

# 🔬 **Biological Background and the Outcome of this pipeline**

🔬 Biological Background & Results Summary

USF2 (Upstream Stimulatory Factor 2) is a bHLH transcription factor that binds the canonical E-box (CACGTG) motif.<br>
This pipeline reveals:

Key Biological Insights:

* Strong enrichment near promoters/TSS regions
* ~20,000 high-confidence summit-centered peaks
* Strongest peak near CDK4 promoter
* Extremely enriched USF family motif

GREAT results show involvement in:

* liver regeneration
* metabolic regulation
* transcriptional programs
* cell cycle regulation

---

# 🔄 Reproducibility — How to Re-run the Exact Pipeline

## 1️⃣ Clone the repository
```bash
git clone https://github.com/SamantGayatri2002/Complete-ChIP-Seq-Pipeline-for-USF2-Transcription-Factor-in-HepG2-Cells.git
cd Complete-ChIP-Seq-Pipeline-for-USF2-Transcription-Factor-in-HepG2-Cells
```


## 2️⃣ Create identical conda environment
```bash
conda env create -f environment.yml
conda activate homer_env
```

## 3️⃣ Run the Pipeline

All scripts are stored under `scripts/` folder, Run the commands inside the activated environment.

This restores the original pipeline environment including:

* BWA
* Samtools
* bedtools
* Picard
* HOMER (hg38 installed)
* deepTools
* Trim Galore
* sra-tools
* Python 3.10



---

# 🔗 Direct File Access 

### **Peak Files**

* [`USF2_peaks.bed`](bam/USF2_peaks.bed)
* [`USF2_summits_200bp.bed`](bam/USF2_summits_200bp.bed)

### **Visualization**

* [`USF2_vs_INPUT_log2.bw`](visualization/USF2_vs_INPUT_log2.bw)
* [`USF2_heatmap.png`](visualization/USF2_heatmap.png)
* [`USF2_profile.png`](visualization/USF2_profile.png)

### **Motifs**

* [`motifs_USF2/`](motifs_USF2/)

### **GREAT Output**

* [`great/`](great/)

### **Scripts**

* [`scripts/`](scripts/)

---


# 🧬 **Key Scientific Outputs**

## 🔹 1. Peak Summary

* Thousands of high-confidence USF2 binding peaks
* Strong promoter & enhancer enrichment
* Example strongest peak:

**CDK4 promoter**, −91 bp from TSS, Peak Score: **394**


## 🔹 2. Motif Discovery

Most significant motif:

* **CACGTG (USF1/USF2 E-box)**
* Target: **~71%**
* Background: **~3%**
* Fold enrichment: **25–30×**
* p-value: **10⁻¹⁶⁶²⁰**

Confirms excellent antibody specificity & TF binding.


## 🔹 3. Functional Enrichment (GREAT)

Enriched pathways include:

* cell-cycle regulation
* liver regeneration
* metabolic processes
* transcriptional regulatory modules

---

# ⚠️ **Limitations**

* Analysis based on single ChIP and Input sample
* HOMER is optimized for TF peaks; consider MACS2 comparison
* GREAT hypergeometric saturation for large peak sets → binomial mode recommended
* WSL2 memory constraints required optimized commands


---

# 🚀 **Future Directions**

* Implement Snakemake/Nextflow for automated workflow management
* Build a Docker/Singularity container for full environment encapsulation
* Add additional replicates or multi-sample comparison
* Integrate RNA-Seq to validate TF target regulation
* MultiQC for QC aggregation

---

# 👩‍🔬 Author

**Gayatri Sunil Samant**<br>
Bioinformatics Intern — Vizzhy, Bangalore

📧 *[gayatrisamant05@gmail.com](mailto:gayatrisamant05@gmail.com)*<br>
🌐 GitHub: [https://github.com/SamantGayatri2002](https://github.com/SamantGayatri2002)




