# -*- coding: utf-8 -*-

survey "ReDSSoCS", :default_mandatory => true do
  
  section "Questions" do

    q "What is your age (in years)?", :is_mandatory => true
    a :integer
    
    q "What sex were you assigned at birth, on your original birth certificate?", :pick => :one
    a "Male"
    a "Female"

    q "What is your current gender identity? (Check all that apply)", :pick => :any
    a "Male"
    a "Female"
    a "Transgender, male-to-female"
    a "Transgender, female-to-male"
    a :other

    q "Are you of Hispanic or Latino origin?", :pick => :one
    a "Yes"
    a "No"

    q "Please select 1 or more categories to describe your race.", :pick => :any
    a "American Indian or Alaska Native"
    a "Asian"
    a "Black or African American"
    a "Native Hawaiian or Other Pacific Islander"
    a "White"

    q "What is your current marital status?", :pick => :one
    a "Married"
    a "Living with someone as if married"
    a "Widowed"
    a "Divorced" 
    a "Separated" 
    a "Never married"
    
    q "How many children have you EVER had, including those who are not now living? Please include any adopted, foster or stepchildren who EVER lived with you."
    a :integer
    
    q "Which of these statements describe your present situation? (Check all that apply)", :pick => :any
    a "Working full time, that is, 35 hours or more per week"
    a "Working part time, that is, less than 35 hours per week"
    a "Have a job or business, but not at work because of temporary illness or injury"
    a "Have a job or business, but on paid vacation"
    a "Have a job or business, but absent from work without pay"
    a "Unemployed or laid off and looking for work"
    a "Unemployed or laid off and not looking for work"
    a "Unemployed and permanently disabled"
    a "Retired"
    a "In school, full time"
    a "In school, part time"
    a "Currently on summer break/holiday from school"
    a "Full-time homemaker"
    a "Something else"
    
    q "What is the highest grade or year of school that you completed?", :pick => :one
    a "No formal schooling"
    a "Completed grade K, 1 or 2"
    a "Completed grade 3 or 4"
    a "Completed grade 5 or 6"
    a "Completed grade 7"
    a "Completed grade 8"
    a "Some high school (grades 9-11)"
    a "Completed high school"
    a "Graduate equivalency degree (GED)"
    a "Some college (no degree)"
    a "Completed associate or other technical 2 year degree"
    a "Completed college (Bachelor’s degree)"
    a "Some graduate or professional studies (completed bachelor’s degree but not graduate degree)"
    a "Completed Master’s degree or equivalent or higher graduate degree"
    
    q "Please report income from all jobs BEFORE taxes and other deductions and net income after business expenses. " + 
      "Include any tips, bonuses, overtime pay and commissions, as well as any income from pensions, dividends, " + 
      "interest, Social Security, alimony, child support, financial aid, support from persons living elsewhere, " +  
      "worker’s compensation or any public assistance or welfare payments and any other money income received by " +  
      "you from ANY OTHER source." + 
      "<br />" + 
      "<br />" + 
      "Can you tell me which category best represents your TOTAL PERSONAL income in the last 12 months?", :pick => :one
    a "$0 (no personal income)"
    a "$1 to $4,999"
    a "$5,000 to $7,999"
    a "$8,000 to $9,999"
    a "$10,000 to $12,999"
    a "$13,000 to $14,999"
    a "$15,000 to $19,999"
    a "$20,000 to $24,999"
    a "$25,000 to $29,999"
    a "$30,000 to $34,999"
    a "$35,000 to $39,999"
    a "$40,000 to $49,999"
    a "$50,000 to $59,999"
    a "$60,000 to $69,999"
    a "$70,000 to $79,999"
    a "$80,000 to $89,999"
    a "$90,000 to $99,999"
    a "$100,000 or more"

    q "During the last 12 months, where did you USUALLY go to obtain health care?", :pick => :one
    a "No place"
    a "Doctor chosen by me"
    a "Doctor assigned by HMO/health care plan"
    a "Hospital outpatient department"
    a "Community clinic or health center"
    a "College/university health center"
    a "Hospital emergency room"
    a "Some other place most often"
    a "Don’t go to one place most often/go to more than one place"
    
    q "At ANY time during the last 12 months were YOU covered by a private health insurance plan obtained through a current or former employer or union?", :pick => :one
    a "Yes"
    a "No"
    
    q "In general, would you say your health is excellent, very good, good, fair or poor?", :pick => :one
    a "Excellent"
    a "Very good"
    a "Good"
    a "Fair"
    a "Poor"
    
    group "And now, please tell me your height and weight as these are important factors for this survey.", :display_type => :inline do
      q "Height (feet)"
      a :integer
      q "Height (inches)"
      a :integer
      q "Weight (pounds)"
      a :integer
    end


    ###  Questions about drinking  ###

    group "The next questions are about drinking alcohol. This includes coolers; beer; wine; champagne; liquor such as whiskey, " + 
      "rum, gin, vodka, bourbon, tequila, scotch, brandy, cognac, cordials, or liqueurs; and also any other type of alcohol", 
      :display_type => :inline do

      q_alcohol_within_past_year "" +
        "<br />" +
        "During the last 12 months, have you had at least 1 drink of any kind of alcohol, not counting small tastes or sips?", :pick => :one
      a_yes "Yes"
      a "No"

      q "During the last 12 months, did you have a total of at least 12 drinks of any kind of alcohol?", :pick => :one
      a "Yes"
      a "No "
      dependency :rule => "D"
      condition_D :q_alcohol_within_past_year, "==", :a_yes

      q "During the last 12 months, about how often did you drink any kind of alcoholic beverage?", :pick => :one
      a "Every day"
      a "Nearly every day"
      a "3 to 4 times a week"
      a "2 times a week"
      a "Once a week"
      a "2 to 3 times a month"
      a "Once a month"
      a "7 to 11 times in the last year"
      a "3 to 6 times in the last year"
      a "1 or 2 times in the last year"
      dependency :rule => "D"
      condition_D :q_alcohol_within_past_year, "==", :a_yes

      q "How many drinks did you USUALLY have on days when you drank during the last 12 months?"
      a :integer
      dependency :rule => "D"
      condition_D :q_alcohol_within_past_year, "==", :a_yes
    
      q_binge_drinking "During the last 12 months, about how often did you drink FOUR OR MORE drinks in a single day?", :pick => :one
      a "Every day"
      a "Nearly every day "
      a "3 to 4 times a week "
      a "2 times a week "
      a "Once a week "
      a "2 to 3 times a month "
      a "Once a month "
      a "7 to 11 times in the last year "
      a "3 to 6 times in the last year "
      a "1 or 2 times in the last year "
      a_never "Never in the last year"
      dependency :rule => "D"
      condition_D :q_alcohol_within_past_year, "==", :a_yes
    
      q "During the last 12 months, about how often did you drink FOUR OR MORE drinks in a period of TWO HOURS OR LESS?", :pick => :one
      a "Every day"
      a "Nearly every day "
      a "3 to 4 times a week "
      a "2 times a week "
      a "Once a week "
      a "2 to 3 times a month "
      a "Once a month "
      a "7 to 11 times in the last year "
      a "3 to 6 times in the last year "
      a "1 or 2 times in the last year "
      a_never "Never in the last year"
      dependency :rule => "B and D"
      condition_B :q_binge_drinking, "!=", :a_never
      condition_D :q_alcohol_within_past_year, "==", :a_yes
    end

    
    ###  Questions about smoking  ###

    q_1 "Did you smoke a cigarette in the last year?", :pick => :one
    a_1 "Yes"
    a "No"
    
    q "About how often did you USUALLY smoke a cigarette in the last 12 months?", :pick => :one
    dependency :rule => "S"
    condition_S :q_1, "==", :a_1
    a "Every day"
    a "5 to 6 days a week"
    a "3 to 4 days a week"
    a "1 to 2 days a week"
    a "2 to 3 days a month"
    a "Once a month or less"


    ###  Questions about drugs  ###
    
    q "Now I’d like to ask you about your experiences with medicines and other kinds of drugs that you may have used ON YOUR OWN – that is, either:" + 
      "<br />" + 
      "<br />" +
      "<li>WITHOUT a doctor’s prescription;</li>" +
      "<li>In GREATER amounts, MORE OFTEN, or LONGER than prescribed; or</li>" +
      "<li>For a reason other than a doctor said you should use them.</li>" +
      "<br />" + 
      "People use these medicines and drugs ON THEIR OWN to feel more alert, to relax or quiet their nerves, to feel better, to enjoy themselves, " +
      "or to get high or just to see how they would work" +
      "<br />" +
      "<br />" + 
      "During the last 12 months, did you use any of these medicines or drugs ON YOUR OWN? Please do not include any over-the-counter medicines or herbal medicines. (Check all that apply)", :pick => :any
    a "Sedatives, for example, sleeping pills, barbiturates, Seconal, Quaaludes, or Chloral Hydrate "
    a "Tranquilizers or anti-anxiety drugs, for example, Valium, Librium, muscle relaxants, or Zanax "
    a "Painkillers, for example, Codeine, Darvon, Percodan, Oxycontin, Dilaudid, Demerol, Celebrex or Vioxx "
    a "Stimulants, for example, Preludin, Benzedrine, Methedrine, Ritalin, uppers, or speed "
    a "Marijuana, hash, THC, or grass Cocaine or crack "
    a "Hallucinogens, for example, Ecstasy/MDMA, LSD, mescaline, psilocybin, PCP, angel dust, or peyote "
    a "Inhalants or solvents, for example, amyl nitrite, nitrous oxide, glue, toluene or gasoline "
    a "Heroin "
    a "Any OTHER medicines, or drugs, or substances, for example, methadone, Elavil, steroids, Thorazine or Haldol?"


    ###  Questions about (?)  ###

    q "Have you tried to hurt or kill yourself, or threatened to do so?", :pick => :one
    a "Yes"
    a "No"

    q "In your ENTIRE life Did you EVER have a very serious or life-threatening illness?", :pick => :one
    a "Yes"
    a "No"
    
    
    ###  Questions about violence  ###
    
    q_violence "In your ENTIRE life Were you EVER sexually assaulted, molested or raped or did you EVER experience unwanted sexual activity?", :pick => :one
    a_yes "Yes"
    a "No"

    q "How old were you the FIRST time this happened?"
    a :integer
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes
    
    q "How old were you the MOST RECENT time this happened?"
    a :integer
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes
    
    q "In your ENTIRE life Before you were 18 years old, were you physically attacked or badly beaten up or injured by either of your parents or any other people who raised you?", :pick => :one
    a "Yes"
    a "No"
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes
    
    q "In your ENTIRE life Before you were 18 years old, were you seriously neglected by either of your parents or any other people who raised you?", :pick => :one
    a "Yes"
    a "No"
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes

    q "In your ENTIRE life Were you EVER physically attacked or badly beaten up or injured by your spouse or romantic partner?", :pick => :one
    a "Yes"
    a "No"
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes

    q "In your ENTIRE life Were you EVER physically attacked or badly beaten up or injured by anyone else?", :pick => :one
    a "Yes"
    a "No"
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes

    q "In your ENTIRE life Were you EVER mugged, held up or threatened with a weapon?", :pick => :one
    a "Yes"
    a "No"
    dependency :rule => "V"
    condition_V :q_violence, "==", :a_yes


    ###  Questions about caregivers  ###

    group "The next few questions are about how your parents or caregivers treated you while you were growing up, that is, BEFORE you were 18 years old. " + 
      "By parents or caregivers, I mean your mother, father, stepmother, stepfather, adoptive mother or father, foster parent or other adult living in your home. ",
      :display_type => :inline do

      q "BEFORE you were 18 years old How often did a parent or other adult living in your home swear at you, insult you or say hurtful things?", :pick => :one
      a "Never"
      a "Almost never"
      a "Sometimes"
      a "Fairly often"
      a "Very often"
    
      q "BEFORE you were 18 years old How often did a parent or other adult living in your home act in ANY other way that made you afraid that you would be physically hurt or injured?", :pick => :one
      a "Never"
      a "Almost never"
      a "Sometimes"
      a "Fairly often"
      a "Very often"
    
      q "How often did your father, stepfather, foster or adoptive father or mother’s boyfriend push, grab, slap or throw something at your mother, stepmother, father’s girlfriend, or your foster or adoptive mother?", :pick => :one  
      a "Never "
      a "Almost never "
      a "Sometimes "
      a "Fairly often "
      a "Very often "
    end


    ###  Questions about health  ###

    q "And now some questions about your health and sexual practices." +
      "<br />" + 
      "<br />" + 
      "People are different in their sexual attraction to other people. Which category on the card best describes your feelings?", :pick => :one
    a "Only attracted to females"
    a "Mostly attracted to females"
    a "Equally attracted to females and males"
    a "Mostly attracted to males"
    a "Only attracted to males"

    q "In your entire life, have you had sex with only males, only females, both males and females, or have you never had sex?", :pick => :one
    a "Only males "
    a "Only females "
    a "Both males and females "
    a "Never had sex"

    q "Which of the categories on the card best describes you?", :pick => :one
    a "Heterosexual (straight) "
    a "Gay or lesbian "
    a "Bisexual "
    a "Not sure"


    ###  Questions about discrimination  ###

    group "Now I’d like to know about how often you have experienced discrimination, been prevented from doing something, or been hassled or made to feel " + 
      "inferior in any of the following situations because you were assumed to be gay, lesbian or bisexual. ", 
      :display_type => :inline do
    
      q "During the last 12 months, about how often did you experience discrimination in your ability to obtain health care or health insurance coverage " + 
        "because you were assumed to be gay, lesbian or bisexual?", :pick => :one
      a "Never "
      a "Almost never "
      a "Sometimes "
      a "Fairly often "
      a "Very often "

      q "During the last 12 months, how often did you experience discrimination in how you were treated when you got care because you were assumed to be gay, lesbian or bisexual?", :pick => :one
      a "Never"
      a "Almost never"
      a "Sometimes"
      a "Fairly often"
      a "Very often"
                    
      q "During the last 12 months, how often did you experience discrimination in public, like on the street, in stores or in restaurants, because you were assumed to be gay, lesbian or bisexual?", :pick => :one
      a "Never "
      a "Almost never "
      a "Sometimes "
      a "Fairly often "
      a "Very often "

      q "During the last 12 months, about how often did you experience discrimination because you were assumed to be gay, lesbian or bisexual in ANY other situation, like obtaining a job or on the job, getting admitted to a school or training program, in the courts or by the police?", :pick => :one
      a "Never"
      a "Almost never"
      a "Sometimes"
      a "Fairly often"
      a "Very often"

      q "During the last 12 months, about how often were you made fun of, picked on, pushed, shoved, hit, or threatened with harm because you were assumed to be gay, lesbian or bisexual?", :pick => :one
      a "Never "
      a "Almost never "
      a "Sometimes "
      a "Fairly often "
      a "Very often"
    end


    ###  Questions about health and suicide  ###

    q "And now a few questions about your health. " +
      "<br />" + 
      "<br />" + 
      "Did you test positive for HIV, the virus that causes AIDS?", :pick => :one
    a "Yes"
    a "No"

    q_attempted_suicide "In your ENTIRE life did you EVER attempt suicide?", :pick => :one
    a_yes "Yes"
    a "No"

    q "Which of the following best describes your experience? (Please check all that apply)", :pick => :any
    a "I thought seriously about it"
    a "I had a general plan but did not carry it out (e.g., a time, a place, etc. were identified)"
    a "I wrote a suicide note but did not leave it where it could be found"
    a "I wrote a suicide note and did leave it where it could be found"
    a "I had a method but did not carry it out"
    a "I made a serious attempt but no medical intervention occurred "
    a "I made a serious attempt that received medical attention "
    a "Although I considered suicide, I was not that serious about it"
    dependency :rule => "A"
    condition_A :q_attempted_suicide, "==", :a_yes



    ###  Questions about online social networks  ###

    q "How frequently do you check Facebook?", :pick => :one
    a "Hourly"
    a "Daily"
    a "Weekly"
    a "Monthly"
    a "Every Several Months"
    a "Never"
    
    grid "Which social networks do you check?" do
      a "Hourly"
      a "Daily"
      a "Weekly"
      a "Monthly"
      a "Every Several Months"
      a "Never"
      q "Twitter", :pick => :one
      q "Google+", :pick => :one
      q "MySpace", :pick => :one
      q "LinkedIn", :pick => :one
      q "Other", :pick => :one
    end

    grid "Do you check any of the following social networking sites?" do
      a "Yes"
      a "No"
      q "Tumblr", :pick => :one
      q "TrevorSpace", :pick => :one
      q "Grindr", :pick => :one
      q "Scruff", :pick => :one
      q "Jack'd", :pick => :one
      q "Hornet", :pick => :one
      q "Yelp", :pick => :one
      q "Foursquare", :pick => :one
      q "Flickr", :pick => :one
      q "YouTube", :pick => :one
      q "Pinterest", :pick => :one
      q "Instagram", :pick => :one
      q "Other", :pick => :one
    end

  end


  section "Estimation Questions" do
    
    ###  "Gaystimate" questions  ###

    q_estimate_total_men "<span id=\"q_estimate_total_men\"></span>Thinking about ALL of your friends, both online (in places like " + 
      "Facebook, Google+, etc.) <i>and</i> in the real world, how many of them are " +
      "men living in the U.S. over the age of 18?"
    a :integer

    q_estimate_total_gb_men "<span id=\"q_estimate_total_gb_men\"></span>Thinking about these <span id=\"a_estimate_total_men\"></span> friends, how many of them would you say identify " +
      "as gay or bisexual?"
    a :integer
    
    
    q_estimate_total_facebook_gb_men "<span id=\"q_estimate_total_facebook_gb_men\"></span>" + 
      "According to Facebook you have <span id=\"male_facebook_friends\">...</span> Facebook friends who are males." +
      "Thinking about ONLY these Facebook friends, how many of them would you say identify as gay or bisexual?" +
      "<div id=\"gb_facebook_friends_slider\"></div>"
    a :integer

    q_estimate_percent_facebook_gb_men "<span id=\"q_estimate_percent_facebook_gb_men\"></span>" + 
      "Based on your previous answer, that would mean <span id=\"estimated_percent_of_gb_friends\">...</span> " +
      "percent of your Facebook friends are gay or bisexual men." +
      "<br />" +
      "<br />" +
      "Do you think this percentage is", :pick => :one
    a_too_low "too low"
    a_about_right "about right"
    a_too_high "too high"

    #  (asked of anyone not responding “about right” to previous question)
    q_just_right "What do you think the right percentage is?"
    a_just_right :integer
    dependency :rule => "L or H"
    condition_L :q_estimate_percent_facebook_gb_men, "==", :a_too_low
    condition_H :q_estimate_percent_facebook_gb_men, "==", :a_too_high

  end
end
