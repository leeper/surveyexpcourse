---
layout: default
title: Home
description: "Survey experiments have emerged as one of the most powerful methodological tools in the social sciences. This course will use published examples of experimental research to demonstrate a variety of ways to leverage survey experiments for testing social science theories."
---

# "Survey Experiments in Practice" Short Course

This page holds materials for a short course called "Survey Experiments in Practice", which I teach from time to time in various places. Feel free to contact me if you would like me to put on workshop about survey experiments. I'm willing to travel!

## Overview

Survey experiments have emerged as one of the most powerful methodological tools in the social sciences. By combining experimental design that provides clear causal inference with the flexibility of the survey context as a site for behavioral research, survey experiments can be used in almost any field to study almost any question. Conducting survey experiments can appear fairly simple but doing them well is hard. 

This course will use published examples of experimental research to demonstrate a variety of ways to leverage survey experiments for testing social science theories. The course will teach participants how to use different survey experimental designs and how to address challenges related to sampling, survey mode, ethics, effect heterogeneity, and more. Students leave the course with a thorough understanding of how survey experiments can provide useful causal inferences, knowledge of how to design and analyze simple and complex experiments, and the ability to evaluate experimental research and apply these methods in their own research.

---

## Upcoming Courses

This course was first taught at the RECSM (Universitat Pompeu Fabra) Barcelona Summer School in Survey Methodology. Materials for the 2017 version of that course are below.

I also teach on this topic in shorter modules. Upcoming versions of the course are:

### NTNU

A two-day workshop at NTNU, Norwegian University of Science and Technology (Trondheim, Norway; 30-31 January 2017). The schedule for the course is as follows:

### Monday 30 January - *Morning*

 - Introduction to surveys, experiments, and the survey-experiment nexus
 - History of survey experimentation
 - Scientific and statistical logic of survey experiments

### Monday 30 January - *Afternoon*

 - Translating theories into experimental designs
 - Common survey experimental paradigms
 - Discussion of applied examples

### Tuesday 31 January - *Morning*

 - Generalizability and external validity
 - Advanced statistical considerations (mediation, effect heterogeneity, etc.)

### Tuesday 31 January - *Afternoon*

 - Practical considerations and handling "broken" experiments
 - Workshop and discussion of participants' designs and experiments
 - Conclusion

 - Slides
   - Day 1 [ ](Slides/NTNU2017-1.pdf)
   - Day 2 [ ](Slides/NTNU2017-2.pdf)

 - Activities
   - Opening Activity: [Data](Activities/activity01.tsv), [Stata (.do)](Activities/activity01.do), [R (.R)](Activiites/activity01.R)
   - Power calculatiosn: [Stata (.do)](Activities/power.do), [R (.R)](Activities/power.R)
 
 
 - Example 1: Holbrook and Krosnick
   - [Paper](Activities/Holbrook/Holbrook, Krosnick (POQ, 2010).pdf)
   - [TESS Record](http://www.tessexperiments.org/data/holbrook120.html)
   - [Questionnaire](Activities/Holbrook/Holbrook, Krosnick (POQ, 2010).pdf)
   - Data: [SPSS (.sav)](Activities/Holbrook/data.sav), [Stata (.dta)](Activities/Holbrook/data.dta)
   - Code: [Stata](Activities/Holbrook/holbrook.R), [R](Activities/Holbrook/holbrook.R)
 
 - Example 2: Schuldt et al.
   - [Paper](Activities/Schuldt/Schuldt, Konrath, Schwarz (POQ, 2011).pdf)
   - [TESS Record](http://www.tessexperiments.org/data/schuldt301.html)
   - [Questionnaire](Activities/Schuldt/Questionnaire.doc)
   - Data: [SPSS (.sav)](Activities/Schuldt/data.sav), [Stata (.dta)](Activities/Schuldt/data.dta)
   - Code: [Stata](Activities/Schdult/schuldt.do), [R](Activities/Schdult/schuldt.R)
 
 - Example 3: Johnston, Newman, and Velez
   - Unpublished
   - [TESS Record](http://www.tessexperiments.org/data/newman508.html)
   - [Questionnaire](Activities/Johnston/questionnaire.doc)
   - Data: [SPSS (.sav)](Activities/Johnston/data.sav), [Stata (.dta)](Activities/Johnston/data.dta)
   - Code: [Stata](Activities/Johnston/johnston.do), [R Code](Activities/Johnston/johnston.R)
 
Note: This version of the workshop includes activities using Stata, but R examples are also provided.


---

# EUI, 2017

A one-day workshop at the Europen University Institute (Florence, Italy; 18 January 2017).

 - [Slides](Slides/EUI2017.pdf)
 - [R Code for Activites](Activities/EUI2017.R)
 - Papers
   - [Holbrook and Krosnick](Activities/Holbrook/Holbrook, Krosnick (POQ, 2010).pdf)
   - [Schuldt et al.](Activities/Schuldt/Schuldt, Konrath, Schwarz (POQ, 2011).pdf)

This version of the workshop includes activities using R.


---

# UPF-RECSM Seminar, 2017

The next full iteration of this course will be taught at the [Barcelona Summer School in Survey Methodology](http://www.upf.edu/survey/Summer/) at Universitat Pompeu Fabra in Barcelona. The short course involves two 4-hour sessions, scheduled to run from 9:00-13:00 each morning July 6-7, 2017. Slides, readings, and materials for each session of the course are available here.


## Syllabus and Schedule

An outline of the course is given below. All of the readings [are available here](https://drive.google.com/open?id=0Bwxjj0JIn0KoYkNIUXhtWFp5OTg).


### Session 1: Survey Experiments in Context (July 6, 9:00-11:00)

The first session will provide an overview of the course, discuss the history of survey experiments and experiments in general, and provide a conceptual and notational framework for design, analyzing, and discussing experiments.

 - [Slides](Slides/lecture01.pdf)
 - Materials from Anchoring Experiment Activity
   - [Data](Activities/activity01.tsv) (tab-separated values)
   - [R script](Activities/activity01.R)
   - [Stata .do file](Activities/activity01.do)

#### Class Schedule

 - 9:00-9:30 - Introductions and Course Overview
 - 9:30-10:00 - History of the Survey Experiment (and Experiments, generally)
 - 10:00-10:50 - Potential Outcomes Framework of Causality

#### Readings

 - Druckman, J. N., Green, D. P., Kuklinski, J. H., and Lupia, A. 2006. "The Growth and Development of Experimental Research in Political Science." *American Political Science Review* 100: 627-635.
 - Kuklinski, J. H. and Hurley, N. L. 1994. "On Hearing and Interpreting Political Messages: A Cautionary Tale of Citizen Cue-Taking" *The Journal of Politics* 56: 729-751.
 - Holland, P. W. 1986. "Statistics and Causal Inference." *Journal of the American Statistical Association* 81: 945-960.


### Session 2: Examples and Paradigms (July 6, 11:00-13:00)

While the first session demonstrated the advantages of experimentation as a research design, designing experiments can be challenging without a solid grounding in a relevant theoretical literature. This session will discuss common paradigms for survey experimental research and discuss how to design experiments to test social science theories.

 - [Slides](Slides/lecture02.pdf)
 - [Description of Experimental Protocol](Activities/protocol.pdf)

#### Class Schedule

 - 11:05-11:30 - Translating Theories into Experiments
 - 11:30-13:00 - Paradigms (Question Wording, Vignettes, Sensitive items, etc.)

#### Readings

 - Schuldt, J. P., Konrath, S. H., and Schwarz, N. 2011. "'Global Warming' or 'Climate Change'?: Whether the Planet is Warming Depends on Question Wording." *Public Opinion Quarterly* 75: 115-124.
 - Glynn, A. N. 2013. "What Can We Learn with Statistical Truth Serum?: Design and Analysis of the List Experiment." *Public Opinion Quarterly* 77: 159-172.
 - Albertson, B. L. and Lawrence, A. 2009. "After the Credits Roll: The Long-Term Effects of Educational Television on Public Knowledge and Attitudes." *American Politics Research* 37: 275-300.


### Session 3: External Validity (July 7, 9:00-11:00)

Experiments are typically performed at one point in time, on a specific sample or set of respondents, on a limited range of issues or topic, using a finite set of measurement techniques. Yet researchers' ambitions are often broader, with aims to make claims that extrapolate beyond the particular study's context, sample, and focus. This session will address various forms of external validity, how to maximize generalizability, and the trade-offs involved with such efforts. 

 - [Slides](Slides/lecture03.pdf)

#### Class Schedule

 - 9:00-9:30 - External Validity
 - 9:30-10:00 - Model-based and Design-based Representativeness
 - 10:00-11:50 - SUTO; Effect Heterogeneity due to Settings and Respondents
 
#### Readings

 - Gaines, B. J., Kuklinski, J. H., and Quirk, P. J. 2007. "The Logic of the Survey Experiment Reexamined." *Political Analysis* 15: 1-20.
 - Druckman, J. N. and Leeper, T. J. 2012. "Learning More from Political Communication Experiments: Pretreatment and Its Effects." *American Journal of Political Science* 56: 875-896.
 - Mullinix, K. J., Leeper, T. J., Druckman, J. N., and Freese, J. 2015. "The Generalizability of Survey Experiments." *Journal of Experimental Political Science*: In press.
 - Green, D. P. and Kern, H. L. 2012. "Modeling Heterogeneous Treatment Effects in Survey Experiments with Bayesian Additive Regression Trees." *Public Opinion Quarterly* 76: 491-511.
 - Warren, J. R. and Halpern-Manners, A. 2012. "Panel Conditioning in Longitudinal Social Science Surveys." *Sociological Research & Methods* 41: 491-534.


### Session 4: Practical Issues in Survey Experimental Research (July 7, 11:00-13:00)

This session will cover a number of remaining issues, especially related to the practical implementation of survey experiments.

 - [Slides](Slides/lecture04.pdf)
 - [Slides](Slides/lecture05.pdf)

#### Class Schedule

 - 11:00-11:30 - Effect Heterogeneity due to Treatments and Outcomes
 - 11:30-12:00 - Lingering Issues (Attention, Satisficing, Self-Selection, Ethics)
 - 12:00-12:45 - Handling of "Broken Experiments"
 - 12:45-13:00 - Summary and Conclusion

#### Readings

 - Clifford, S. and Jerit, J. 2015. "Do Attempts to Improve Respondent Attention Increase Social Desirability Bias?" *Public Opinion Quarterly* 79: 790-802.
 - Bolsen, T. 2013. "A Light Bulb Goes On: Norms, Rhetoric, and Actions for the Public Good." *Political Behavior* 35: 1-20.
 - Hainmueller, J., Hangartner, D., and Yamamoto, T. 2015. "Validating Vignette and Conjoint Survey Experiments Against Real-World Behavior." *Proceedings of the National Academy of Sciences*: In press.
 - Leeper, T. J. ["The Role of Media Choice and Media Effects in Political Knowledge Gaps."](https://dl.dropboxusercontent.com/u/414906/KnowledgeGaps.pdf) Working paper, London School of Economics and Political Science.
 - Hertwig, R. and Ortmann, A. 2008. "Deception in Experiments: Revisiting the Arguments in Its Defense." *Ethics & Behavior* 18: 59-92.



---

## Further Reading

Though not assigned for the course, the following texts may serve as useful background reading or places for further inspiration in the design and analysis of survey experiments.

### Books

 * Mutz, D. C. 2011. *Population-Based Survey Experiments*. Princeton, NJ: Princeton University Press.
 * Gerber, A. S. and Green, D. P. 2012. *Field Experiments: Design, Analysis, and Interpretation*. New York: W.W. Norton.
 * Schuman, H. and Presser, S. 1981. *Questions and Answers in Attitude Surveys: Experiments on Question Form, Wording, and Context*. SAGE Publications.
 * Groves, R. M., Fowler, F. J., Couper, M. P., Lepkowski, J. M., Singer, E., and Tourangeau, R. 2009. *Survey Methodology*. Wiley-Interscience.
 
### Survey, Experimental, and Survey-Experimental Methodology

 * Blair, G. and Imai, K. 2012. "Statistical Analysis of List Experiments." *Political Analysis* 20: 47-77.
 * Jamieson, J. P. and Harkins, S. G. 2011. "The Intervening Task Method: Implications for Measuring Mediation." *Personality & Social Psychology Bulletin* 37: 652-661.
 * Green, D. P., Ha, S. E., and Bullock, J. G. 2009. "Enough Already about 'Black Box' Experiments: Studying Mediation is More Difficult than Most Scholars Suppose." *The ANNALS of the American Academy of Political and Social Science* 628: 200-208.
 * Imai, K., Keele, L. Tingley, D., and Yamamoto, T. 2011. "Unpacking the Black Box: Learning about Causal Mechanisms from Experimental and Observational Studies." *American Political Science Review* 105(4): 765-789.
 * Wang, W., Rothschild, D., Goel, S., and Gelman, A. 2015. "Forecasting Elections with Non-representative Polls." *International Journal of Forecasting*: In press.
 * Chandler, J., Paolacci, G., Peer, E., Mueller, P., and Ratliff, K. A. 2015. "Using Nonnaive Participants Can Reduce Effect Sizes." *Psychological Science*: In press.
 * Banducci, S. and Stevens, D. 2015. "Surveys in Context: How Timing in the Electoral Cycle Influences Response Propensity and Satisficing." *Public Opinion Quarterly* 79: 214-243.
 * Hainmueller, J., Hopkins, D. J., and Yamamoto, T. 2014. "Causal Inference in Conjoint Analysis: Understanding Multi-Dimensional Choices via Stated Preference Experiments." *Political Analysis* 22: 1-30.
 * Tourangeau, R. and Smith, T. W. 1996. "Asking Sensitive Questions: The Impact of Data Collection Mode, Question Format, and Question Context." *Public Opinion Quarterly* 60: 275-304.
 * Kreuter, F., Presser, S., and Tourangeau, R. 2009. "Social Desirability Bias in CATI, IVR, and Web Surveys: The Effects of Mode and Question Sensitivity." *Public Opinion Quarterly* 72: 847-865.
 * Hovland, C. I. 1959. "Reconciling Conflicting Results Derived from Experimental and Survey Studies of Attitude Change." *American Psychologist* 14: 8-17.
 * Sterling, T. D., Rosenbaum, W. L., and Weinkam, J. 1995. "Publication Decisions Revisited: The Effect of the Outcome of Statistical Tests on the Decision to Publish and Vice Versa." *The American Statistician* 49: 108-112.
 * Franco, A., Malhotra, N., and Simonovits, G. 2015. "Underreporting in Political Science Survey Experiments: Comparing Questionnaires to Published Results." *Political Analysis* 23: 306-312.
 * Gelman, A., and Stern, H. 2006. "The Difference Between 'Significant' and 'Not Significant' is Not Itself Statistically Significant." *The American Statistician* 60(4): 328-331.

---

## Instructor Bio

[Thomas J. Leeper](http://www.thomasleeper.com) is an Assistant Professor in Political Behaviour in the [Department of Government](http://www.lse.ac.uk/government/home.aspx) at the [London School of Economics and Political Science](http://www.lse.ac.uk/). He studies public opinion dynamics using survey and experimental methods, with a focus on citizens' information acquisition, elite issue framing, and party endorsements within the United States and Western Europe. His research has been published in leading journals, including *American Political Science Review*, *American Journal of Political Science*, *Public Opinion Quarterly*, and *Political Psychology* among others.
