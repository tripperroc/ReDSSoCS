class RedssocsSurveyConsent < ActiveRecord::Base

  # -------- Original Message --------
  # Subject: Eligibility screening questions
  # Date: Fri, 21 Dec 2012 15:06:27 -1000
  # From: Craig Harman <charman@cs.rochester.edu>
  # To: Silenzio, Vincent <Vincent_Silenzio@URMC.Rochester.edu>,  Christopher M Homan, PhD <cmh@cs.rit.edu>, Randall Sell <Randy@drexel.edu>
  # 
  # Just to confirm my understanding of what we talked about today...
  # 
  # 
  # There are four (non-exclusive) options for "Do you consider yourself to be":
  # 
  #  heterosexual or straight
  #  gay
  #  bisexual
  #  other/not sure/don't know
  # 
  # My understanding is that only the following three combinations satisfy 
  # the eligibility criteria:
  # 
  #   gay
  #   bisexual
  #   gay AND bisexual
  # 
  # Here's the corresponding truth table:
  # 
  #   heterosexual or straight    X X X X X X X       X
  #   gay                         X X X   X     X X     X
  #   bisexual                    X X   X   X   X   X     X
  #   other/not sure/don't know   X   X X     X   X X       X
  #   -------------------------
  #   Eligible?                   n n n n n n n Y n n n Y Y n
  #
  # [...]
  # 
  # For gender, there are three non-exclusive options:
  # 
  #   male
  #   female
  #   other
  # 
  # and only people who choose "male" (and only "male") are eligible:
  # 
  #   male        X X   X
  #   female      X X X   X
  #   other       X   X     X
  #   ------
  #   Eligible?   n n n Y n n


  def eligible?
    eighteen_or_older && (gender == "Male" || gender == "Female-to-Male") && (orientation == "Gay" || orientation == "Bisexual")
  end

  def self_identifies_as_only_gay_or_bisexual?
    (!heterosexual && gay && bisexual && !other) ||
      (!heterosexual && gay && !bisexual && !other) ||
      (!heterosexual && !gay && bisexual && !other)
  end

  def self_identifies_as_only_male?
    gender_male && !gender_female && !gender_other
  end

end
