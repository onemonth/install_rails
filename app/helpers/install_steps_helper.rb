module InstallStepsHelper

  def percent_completed
    number_to_percentage((wizard_steps.index(step) / wizard_steps.size.to_f)*100, precision: 0)
  end

  def progress_bar
    content_tag :div, class: "progress" do
      content_tag :div, nil, class: "bar", style: "width: #{percent_completed};"
    end
  end
end
