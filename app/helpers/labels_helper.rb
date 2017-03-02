module LabelsHelper
  def labels_to_buttons(labels)
    raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-sm label-container' }.join(' ')
  end
end
