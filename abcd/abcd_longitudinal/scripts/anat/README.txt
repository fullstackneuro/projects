Description: This set of scripts is responsible for preprocessing subject anatomical (T1) data into data derivatives useful for diffusion tractography and functional preprocessing.
It includes programs for  untarring, acpc-alignment, freesurfer segmentation, ANTs transform and inverse transform, ROI generation, ROI combination and smoothing.
The order of scripts provided here is not strictly necessary, but certain scripts must precede others (for instance, untarring must always happen first. ACPC alignment must happen before freesurfer, etc.).
For a subject who has not yet been processed, the recommended order of operations is as follows:



untar_t1: This script takes three parameters which are available for editing up top.
	The tar path is the location of the raw t1 tar files
	The extract path is where you wish to place the untarred files
	the subject list is the list of raw files you wish to run.
	Note that the subject list should be a column, delimited by new lines, containing names for the raw tar files (including file extensions) that you wish to extract.
	Running this script will create an extract (bids) directory (if it doesn't already exist) and place raw subject T1's within a subject folder in that directory.

auto_acpc: This script takes the raw T1 file extracted previously as input and outputs an acpc-aligned T1.
	The script takes four parameters, available for editing up top.
	The t1 directory is where the untarred raw T1s are stored (should be the bids folder)
	The subject list is a textf file as before, containing a list of raw subject tar files
	The template is the reference that the auto-acpc script uses to perform alignment. This is currently set to the MNI152 standard brain with 1mm resolution.
	Type tells the script what sort of anatomical file it is aligning. For our purposes, this is a T1 file.
	Running the script will create an acpc folder under the subject's bids folder. Within that folder are the intermediate fileds used during alignment, along with an output folder containing the acpc-aligned T1.

run_fs: This script takes a subject's acpc aligned T1 file and performs freesurfer segmentation.
	The script takes three parameters, available for editing up top.
	The FREESURFER_HOME directory is the location in which freesurfer is installed on the local device.
	The freesurfer directory is the location where you wish to output the subject's freesurfer files.
	The input directory is where freesurfer should look to find the acpc aligned T1 files (shoudl be bids).
	NOTE: THIS SCRIPT IS NOT RUN BY ITSELF. To run this script, refer to the following script.

dist_fs: Because freesurfer is very resource intensive and takes time to complete, we often parallelize it across terminals to speed up processing.
	This script takes care of that parallelization, determining the number of cores available on the local device,
	and taking two parameters as input.
	ncores tells freesurfer how many CPU threads you want to allocate to each instance of freesurfer.
	sub_list tells freesurfer which subjects to run, and contains a list of raw .tgz filenames
	This script computes the number of terminals to distribute freesurfer across, divides the subject list into sub_lists of equal length, and runs freesurfer on each subject list in a loop.
	The output of this script is a freesurfer folder for each subject, containing the seg file which will be used later when processing diffusion.
	NOTE: THIS IS THE SCRIPT YOU RUN IN TERMINAL. NOT RUN_FS.






****************************************************************************************************************************************************************************************************************************************************************************************************************
NOTE: THIS IS THE EXTENT OF SCRIPTS THAT CAN BE RUN BEFORE RUNNING DIFFUSION PREPROCESSING. ALL THE FOLLOWING SCRIPTS REQUIRE THAT YOU RUN DIFFUSION AT LEAST THROUGH DTIINIT, AS THEY MAKE USE OF FOLDERS AND PRODUCTS WHICH THAT SCRIPT GENERATES. REFER TO THE DIFFUSION SCRIPTS FOLDER README.txt FILE FOR MORE INFORMATION.
*************************************************************************************************************************************************************************************************************************************************






create_seg_file: This script takes a .mgz segmentation file produced by freesurfer and converts it into nifti format, which we later use to extract ROIs for tracking.
		The script takes four parameters.
		FREESURFER_HOME is the device-specific location where freesurfer is installed.
		fsPath is the path to the subject's freesurfer folder.
		matPath is the path to the subject's matproc folder.
		txtfile is a file containing a list of subject raw files, indicating which subjects to run.
		The output of this script is a nifti format segmentation file placed in the subject's ROIs folder under matproc.

fs_roi2mat: This script takes the segmentation nifti files in the subject's matproc folder and splits it into many ROI mat files.
		The script itself is a bash wrapper for a matlab script: fs_dtiConvFSroi2mat.m. This script should not need to be edited, but is available in the same scripts folder just in case.
		This script takes two parameters:
		matPath is the path to the subject matproc folders.
		textfile is a list of subject raw files, indicating which subjects to run.
		Outputs of this script include many ROI files in .mat form, placed in the subject's ROIs folder under matproc.

make_and_smooth_roi: This script takes the mat ROI files produced by fs_roi2mat, and modifies them to produce modified ROIs that are useful for our tracking scripts.
		The script itself is a bash wrapper for three matlab scripts, which it runs in linear succession.
		The first merges the anterior insula ROI with the short insula ROI to create an antshortins ROI, which we refer to as AINs. 
		The second merges multiple white-matter ROIs to create a global white-matter mask for general probabilistic tractography.
		The third inflates ROIs by a few voxels, and smooths them to remove jagged edges.
		These matlab scripts should not require modification, but are available in the same scripts folder regardless.
		This script takes three parameters.
		FREESURFER_HOME is the device-specific path to the freesurfer installation.
		matprocPath is the path to the subjects' matproc folders
		txtfile is a subject list containing subject raw filenames, indicating which subjects to run. 
		The outputs of this script include bilateral antshortins ROIs, a global whitematter mask, and smoothed ROIs for regions which are relevant to our diffusion tractography scripts.

ants_affine_warp: This script generates a set of ANTs transform files that we use to transform a standard VTA atlas into subject space.
		It is a bash wrapper that runs a matlab script. The matlab script should not require editing, but is available in the same scripts folder for inspection if needed.
		This script takes three parameters.
		The matproc path is the location in which to look for the outputs of dtiInit for each subject (namely the brain mask file)
		The template path is the location of your standard brain and brain mask templates. We generally use MNI and NIHPD.
		the text file is the list of subject raw files which indicates which subjects to process.
		The outputs of this script, though anatomical, are placed in the subject's matproc folder in the diffusion preprocessing directory.
		Outputs include an affine transform matrix (text file) and an affine warp matrix (nifti file) placed at the top level of the subject's matproc folder.

ants_inverse_xform: This script uses the transform files generated by ants_affine_warp to back-transform standard-space ROIs into subject space.
		It is a bash wrapper that runs a matlab script. The matlab script should not require editing, but is available in the same scripts folder for inspection if necessary.
		This script takes three parameters.
		The matproc path is the location in which to look for the outputs of dtiInit for each subject.
		The template path is the location of your standard ROI templates (such as VTA).
		The text file is the list of subject raw files which indicates which subjects to process.
		The outputs of this script, though anatomical, are placed in the subject's ROI folder under matproc.
		Outputs include binarized subject-space masks for the standard ROIs indicated in the matlab script.


