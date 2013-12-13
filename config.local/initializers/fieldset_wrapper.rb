module Formtastic
  module Helpers
    module FieldsetWrapper

      #  Monkeypatch to modify Formtastic's HTML output by wrapping questions in a <div>
      #
      #  By default, when Formtastic renders a form, each question is wrapped solely
      #  in a <fieldset>:
      #
      #        <div class="survey_section">
      #          <fieldset class="q_default" id="q_1">
      #            <legend>Question text</legend>
      #            <ol>
      #              Form fields for answers
      #            </ol>
      #          </fieldset>
      #          <fieldset class="q_default" id="q_2">
      #            <legend>Question text</legend>
      #            <ol>
      #              Form fields for answers
      #            </ol>
      #          </fieldset>
      #          ...
      #        </div>
      #       
      #  Unfortunately, <fieldset> elements can't be styled consistently across browsers
      #  like other HTML block-level elements.  For example, adding a 'border-top: solid' 
      #  style to the top of a <fieldset> will vertically align the border with the
      #  center of the text in the <fieldset>'s <label> tag.  You can't add a 'border-top'
      #  to a <fieldset> and have the border run along the entire width of the <fieldset>
      #
      #  The Formtastic::Helpers::FieldsetWrapper method field_set_and_list_wrapping
      #  generates the <fieldset> tags used to display questions.
      #
      #  This monkeypatch wraps the output of the original field_set_and_list_wrapping
      #  method in a <div> tag, which makes it easier to modify the appearances of 
      #  questions using CSS.

      alias_method :orig_field_set_and_list_wrapping, :field_set_and_list_wrapping

      def field_set_and_list_wrapping(*args, &block)
        template.content_tag(:div,
          orig_field_set_and_list_wrapping(*args, &block),
          :class => "fieldset_wrapper"
        )
      end

    end
  end
end
