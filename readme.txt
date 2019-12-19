README FILE FOR GROUP 7 DATA ANALYTICS AND PREDICTIVE MODELING

The "US Accidents May19" file is the main dataset we use. 

1. Please note that the project folder shared with you has four subfolders. 
   Our analysis was performed over four states. You will find each folder corresponding to a state we analyzed. 

2. There are four scripts and an Rdata file in each folder. 
3. The Rdata file should contain all the trained objects, you will not need to train anything from scratch. 
4. Load the rdata file and the four scripts. 
5. The Scripts:
	base_script_States => cleans the data up and finally outputs one state's balanced data. 
	tuning_models => is a generic script where you set the dataframe to be trained. 
			 Use the final df object from the base script here. 
			 for instance, use "df = balanced_state_WA" for Washington (this object is in the Rdata file too)
	                 It trains from the data for all the models. 
			 Uses Caret, hence objects created here are train objects.
	post_tuning => tests all the trained models on the testing data. Uses the caret train objects created in tuning. 
		       Each subsection in the code tests a different model and outputs the accuracy. 
	   	       Finally outputs Variable Importance Plots from the RF models. 
	logit_model => Trains and tests a logit model. Unique to each state. Do not tinker. Run to get final accuracy. 




	
