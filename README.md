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


* Raw data acquisition (SRA → FASTQ)
* Read QC, filtering, and adapter trimming
* Alignment to hg38 (BWA-MEM)
* BAM processing, sorting, deduplication, blacklist removal
* Peak calling using HOMER
* Peak annotation using HOMER (hg38)
* Motif discovery (known + de novo)
* GREAT functional enrichment
* Genome-wide signal visualization using deepTools
* IGV-ready track generation
* Biological interpretation of USF2 function


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

USF2 (Upstream Stimulatory Factor 2) is a basic helix-loop-helix transcription factor that binds the canonical **E-box motif (CACGTG)**.
It regulates:

* metabolic processes
* oxidative and stress-response pathways
* cell-cycle progression (e.g., CDK4)
* chromatin regulatory programs

Analysis revealed:

* strong promoter-TSS binding
* enriched E-box motifs (~71% of peaks)
* ~20,000 summit-centered regulatory regions
* biologically meaningful GREAT enrichment terms

---

# 🔄 **Reproducibility Guide**

## ✅ 1. Clone Repository

```bash
git clone https://github.com/<your-username>/ChIP-Seq-USF2-Analysis.git
cd ChIP-Seq-USF2-Analysis
```


## ✅ 2. Create the Identical Conda Environment

```bash
conda env create -f environment.yml
conda activate homer_env
```

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


## ✅ 3. Run the Pipeline 

All scripts are stored under `scripts/` folder, Run the commands inside the activated environment.



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

# 🔗 **Important Direct Links **

### 📁 **Peak Files**

* `bam/USF2_peaks.bed`
* `bam/USF2_summits_200bp.bed`

### 📁 **Visualization**

* `visualization/USF2_vs_INPUT_log2.bw`
* `visualization/USF2_heatmap.png`
* `visualization/USF2_profile.png`

### 📁 **Annotation**

* `bam/USF2_peak_annotation.txt`

### 📁 **Motifs**

* `motifs_USF2/`

### 📁 **GREAT Results**

* `great/`

---

# 🚀 **Future Directions**

* Implement Snakemake/Nextflow for automated workflow management
* Build a Docker/Singularity container for full environment encapsulation
* Add additional replicates or multi-sample comparison
* Integrate RNA-Seq to validate TF target regulation
* Develop a MultiQC dashboard for QC aggregation

---

# ⚠️ **Limitations**

* Analysis based on single ChIP and Input sample
* HOMER is optimized for TF peaks; consider MACS2 comparison
* GREAT hypergeometric saturation for large peak sets → binomial mode recommended
* WSL2 memory constraints required optimized commands

---

# 👩‍🔬 **Author**

**Gayatri Sunil Samant**<br>
Bioinformatics Intern at **Vizzhy**, Banglore<br>
India

📧 **Email:** *gayatrisamant05@gmail.com*<br>
🌐 **GitHub:** *https://github.com/SamantGayatri2002*

---

# 📄 **Citation**

If you use this repository, please cite:

**Dataset:** GEO Series **GSE104247**<br>
**Tools:** HOMER, deepTools, BWA, Samtools, Picard, bedtools


