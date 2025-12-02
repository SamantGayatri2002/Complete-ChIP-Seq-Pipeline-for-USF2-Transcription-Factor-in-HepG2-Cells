#!/bin/bash
set -euo pipefail 
# “Stop immediately if anything goes wrong — a failed command, a typo in a variable, or an error inside a pipeline.”

# ------------------------------------------------------------------
# Minimal ChIP-seq visualization pipeline (deepTools + IGV-ready)
# Saves outputs to: ~/GSE104247/visualization/
# Designed for the below folder layout:
#   ~/GSE104247/bam/USF2_clean.bam
#   ~/GSE104247/bam/INPUT_clean.bam
#   ~/GSE104247/bam/USF2_peaks.bed
# Requires: deepTools (bamCoverage, bamCompare, computeMatrix, plotHeatmap, plotProfile)
# ------------------------------------------------------------------

WORKDIR="$HOME/GSE104247"
BAMDIR="${WORKDIR}/bam"
OUTDIR="${WORKDIR}/visualization"

# create output directory
mkdir -p "${OUTDIR}"

# move into bam directory for inputs (keeps things predictable)
cd "${BAMDIR}"

echo "Using BAM directory: ${BAMDIR}"
echo "Visualization outputs will be written to: ${OUTDIR}"
echo

# ---------------------------
# Step 1: make BigWig signal tracks
# ---------------------------
# Reason: bigWig files are compact and fast for visualization (IGV & deepTools)
# We create one for ChIP and one for Input. Files are written to OUTDIR.
# ---------------------------

echo "STEP 1: Generating BigWig files (USF2 and INPUT)"

bamCoverage \
  --bam USF2_clean.bam \
  --outFileName "${OUTDIR}/USF2.bw" \
  --binSize 10 \
  --normalizeUsing RPKM \
  --numberOfProcessors 4

bamCoverage \
  --bam INPUT_clean.bam \
  --outFileName "${OUTDIR}/INPUT.bw" \
  --binSize 10 \
  --normalizeUsing RPKM \
  --numberOfProcessors 4

echo "BigWig files created: ${OUTDIR}/USF2.bw  ${OUTDIR}/INPUT.bw"
echo

# ---------------------------
# Step 2: create log2(ChIP/Input) normalized track
# ---------------------------
# Reason: best single-track representation of true enrichment (background corrected)
# Operation = log2(ChIP / Input)
# ---------------------------

echo "STEP 2: Creating log2(USF2 / INPUT) BigWig (background-corrected)"

bamCompare \
  -b1 USF2_clean.bam \
  -b2 INPUT_clean.bam \
  --operation log2 \
  --outFileName "${OUTDIR}/USF2_vs_INPUT_log2.bw" \
  --binSize 10 \
  --numberOfProcessors 4

echo "Log2 track created: ${OUTDIR}/USF2_vs_INPUT_log2.bw"
echo

# ---------------------------
# Step 3: compute matrix around peak centers
# ---------------------------
# Reason: computeMatrix collects numerical signal around each peak center,
# producing a matrix used for heatmap and profile plots.
# -R uses your peak BED
# -S uses the log2 normalized signal track (preferred)
# ---------------------------

PEAKS="${BAMDIR}/USF2_peaks.bed"
MATRIX="${OUTDIR}/matrix_USF2.gz"

echo "STEP 3: Computing matrix around peak centers (±2kb w/ 10bp bins)"
computeMatrix reference-point \
  --referencePoint center \
  -b 2000 -a 2000 \
  -R "${PEAKS}" \
  -S "${OUTDIR}/USF2_vs_INPUT_log2.bw" \
  --skipZeros \
  --missingDataAsZero \
  --binSize 10 \
  -o "${MATRIX}" \
  --numberOfProcessors 4

echo "Matrix written to: ${MATRIX}"
echo

# ---------------------------
# Step 4: plot heatmap
# ---------------------------

HEATMAP_PNG="${OUTDIR}/USF2_heatmap.png"
echo "STEP 4: Plotting heatmap -> ${HEATMAP_PNG}"

plotHeatmap \
  -m "${MATRIX}" \
  -out "${HEATMAP_PNG}" \
  --colorMap Reds \
  --regionsLabel "USF2 Peaks" \
  --heatmapHeight 10 \
  --heatmapWidth 4

echo "Heatmap generated."
echo

# ---------------------------
# Step 5: plot average profile
# ---------------------------

PROFILE_PNG="${OUTDIR}/USF2_profile.png"
echo "STEP 5: Plotting average profile -> ${PROFILE_PNG}"

plotProfile \
  -m "${MATRIX}" \
  -out "${PROFILE_PNG}" \
  --regionsLabel "USF2 Peaks"

echo "Profile plot generated."
echo

# ---------------------------
# Final message
# ---------------------------

echo "Visualization complete. Files in ${OUTDIR}:"
ls -lh "${OUTDIR}" | sed -n '1,200p'

echo
echo "Minimal IGV upload suggestion (only these files):"
echo "  ${BAMDIR}/USF2_peaks.bed"
echo "  ${OUTDIR}/USF2_vs_INPUT_log2.bw"
echo "  Optional files "
echo "  ${BAMDIR}/USF2_clean.bam"
echo "  ${BAMDIR}/USF2_clean.bam.bai"
echo "  ${BAMDIR}/INPUT_clean.bam"
echo "  ${BAMDIR}/INPUT_clean.bam.bai"
echo "  ${BAMDIR}/USF2_peaks.bed"
# - Important files to visualize (recommended):
#     USF2_vs_INPUT_log2.bw   (best overall signal)
#     USF2_peaks.bed          (see peaks on genome)
#
# - Optional files for pileup viewing:
#     USF2_clean.bam + .bai
#     INPUT_clean.bam + .bai
#   (Only needed if you want to inspect actual aligned reads)

