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


<br>

## 🧭 **Project Summary**

Chromatin Immunoprecipitation followed by sequencing (ChIP-Seq) enables genome-wide mapping of protein–DNA interactions.  This repository provides a **fully reproducible ChIP-Seq analysis pipeline** for the transcription factor **USF2** in **HepG2** cells, leveraging raw sequencing data from **GSE104247**. All analyses—including alignment, peak calling, motif discovery, GREAT enrichment, and visualization—were performed once, and the entire workflow is made reproducible through a preserved **conda environment**, standardized folder structure, and documented scripts.

---

<br>

# 📘 **This pipeline mainly follows the below steps**

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

<br>

---

# 🔬 Biological Background

USF2 (Upstream Stimulatory Factor 2) is a basic helix–loop–helix (bHLH) transcription factor that recognizes and binds the E-box motif (CACGTG) across the genome. Through this binding, USF2 regulates genes involved in metabolism, cell-cycle progression, and stress-response pathways. In HepG2 liver cells, USF2 plays a role in maintaining transcriptional homeostasis and modulating regulatory elements near promoters and enhancers.

---
<br>


# 📁 Repository Structure

```
ChIP-Seq-USF2-Analysis/
├── scripts/                 # It contain the Entire Pipeline Explained stepwise with commands and aslo one bash script to automate the visualisation outputs
├── trim/                    # It has Trim Galore + FastQC outputs
├── bam/                     # It has alignment outputs like cleaned/sorted?indexed BAMs, Deduplicated output files, Flagstat reports,  peak files etc..
├── visualization/           # It has bigWig files, heatmaps, profile plots
├── IGV/                     # It has the saved snpshots of IGV results
├── motifs_USF2/             # It has HOMER motif results (logos, PWMs, HTML), Known as well as De-Novo motif files
├── GREAT_Results/           # GREAT output for summit-centered regions
├── docs/                    # It has Additional informations, Enhanced pipeline with outcomes, IGV Guide, Answers to some biological questions
├── environment.yml          # It has conda environment used for the analysis, it can be used for reproducing the same pipeline
└── README.md                # It has Overview about the current repository

```
<br>

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

<br>

# **🔎 Outputs & interpretation summary**

Typical outputs you will find (or produce) in this pipeline:

1. *.bw (bigWig): normalized coverage for USF2 and Input (visualization / IGV).
2. *_peaks.bed: HOMER-called peak sets — use for motif analysis and GREAT.
3. motifs_USF2/: HOMER motif reports (expected enrichment of E-box / CACGTG pattern for USF2).
4. GREAT_Results/: ontology and regulatory enrichment for summit-centered regions.
5. visualization/: heatmaps and profile plots (aggregate signal around TSS/summits). 


---
<br>

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
<br>

## Reproducibility notes & best practices

- Always use the provided environment.yml to recreate the exact software environment (or freeze packages to explicit versions). 
GitHub
- Edit scripts to point to your local reference genome (hg38 FASTA and index) and the correct chromosome sizes for deepTools.
- Keep intermediate files (trimmed FASTQ, BAMs) organized per sample — it helps debugging and re-running individual steps.
- For peak calling, compare results with at least one other caller (e.g., MACS2) if you plan a publication; HOMER is the pipeline used here but cross-validation is recommended.

---
<br>

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
<br>


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
<br>

# ⚠️ **Limitations**

* Analysis based on single ChIP and Input sample
* HOMER is optimized for TF peaks; consider MACS2 comparison
* GREAT hypergeometric saturation for large peak sets → binomial mode recommended
* WSL2 memory constraints required optimized commands


---
<br>

# 🚀 **Future Directions**

* Implement Snakemake/Nextflow for automated workflow management
* Build a Docker/Singularity container for full environment encapsulation
* Add additional replicates or multi-sample comparison
* Integrate RNA-Seq to validate TF target regulation
* MultiQC for QC aggregation

---
<br>

# 👩‍🔬 Author

**Gayatri Sunil Samant**<br>
Bioinformatics Intern — Vizzhy, Bangalore

📧 *[gayatrisamant05@gmail.com](mailto:gayatrisamant05@gmail.com)*<br>
🌐 GitHub: [https://github.com/SamantGayatri2002](https://github.com/SamantGayatri2002)




