Description: This small set of scripts is responsible for taking the raw behavior files provided by ABCD and modifying them so that they can be joined with the 1D timecourse files produced by AFNI for timecourse analysis.
It includes programs for unzipping the raw behavior csv files and expanding those files into a format that can be cbinded with the afniproc timecourses.
The order of these two scripts is (obviously) necessary, as the raw behavior file must be present before it can be modified.
For a subject who has not yet been processed, the order of operations is as follows:


unzip_mid: This script takes three parameters, which are available for editing up top.
	zip_path is the path to the subject behavior zip folders, as provided by ABCD.
	extract_path is the folder in which the extracted behavior file will be placed (should be bids).
	sub_list is a list of subject raw files to perform preprocessing on. Raw files are new-line delimited, and contain the full filename for the raw csv zip files.
	NOTE: Because of the way that the timepoint is encoded in the raw file name, the string must be reconstructed to be compatible with the format of the timepoint string for the other data types.
	As such, some hard-coding is required to match up these timepoints. As new ABCD releases come out (6 year follow up, etc.), new lines will need to be added to the if-statements responsible for
	constructing these timepoint strings.
	The output of this script is a raw behavior file, placed in the subject's bids folder.



mid_expand_behav: This script takes the raw behavior csv provided by abcd and inflates it, adding in new rows so that each TR of the task is accounted for when the behavior file is combined with the 1D timecourse files.
		The script is a wrapper for an R script. The R script should not require modification, but is avaiable in this scripts folder for inspection should the need arise.
		This script takes three parameters.
		The bids path is the path to the subject bids folder, containing the raw behavior files.
		The afni path is the path to the subject afniproc folder
		The sublist is a text file containing a list of raw behavior files, indicating which subjects to run.
		The output of this script is an expanded behavior file, along with modified events files that include information about the duration of particular trial phases during MID.
		These outputs are placed in the subject's afniproc folder.
