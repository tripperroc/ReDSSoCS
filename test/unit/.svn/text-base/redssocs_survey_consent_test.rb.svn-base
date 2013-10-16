require 'test_helper'

class RedssocsSurveyConsentTest < ActiveSupport::TestCase

  test "self identifies as only gay or bisexual" do
    # Eligible conditions

    rsc = RedssocsSurveyConsent.new
    rsc.gay = true
    rsc.bisexual = false
    assert rsc.self_identifies_as_only_gay_or_bisexual?

    rsc = RedssocsSurveyConsent.new
    rsc.gay = false
    rsc.bisexual = true
    assert rsc.self_identifies_as_only_gay_or_bisexual?
    
    rsc = RedssocsSurveyConsent.new
    rsc.gay = true
    rsc.bisexual = true
    assert rsc.self_identifies_as_only_gay_or_bisexual?
    
    
    # Ineligible conditions
    
    rsc = RedssocsSurveyConsent.new
    rsc.gay = false
    rsc.bisexual = false
    assert !rsc.self_identifies_as_only_gay_or_bisexual?
    
    rsc = RedssocsSurveyConsent.new
    rsc.gay = true
    rsc.bisexual = true
    rsc.other = true
    assert !rsc.self_identifies_as_only_gay_or_bisexual?
  end

  
  test "self identifies as only male" do
    # Eligible conditions

    rsc = RedssocsSurveyConsent.new
    rsc.gender_male = true
    assert rsc.self_identifies_as_only_male?


    # Ineligible conditions
    
    rsc = RedssocsSurveyConsent.new
    assert !rsc.self_identifies_as_only_male?

    rsc = RedssocsSurveyConsent.new
    rsc.gender_male = true
    rsc.gender_other = true
    assert !rsc.self_identifies_as_only_male?
  end
  
end
