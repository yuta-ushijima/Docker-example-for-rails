class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user
  # ActiveStorageの機能で画像添付のための関連付け
  # has_one_attachedは1つのタスクに1つの画像を紐付ける
  has_one_attached :image

  scope :recent, -> { order(created_at: :desc)}

  def self.csv_attributes
    %w[name description created_at updated_at]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attribute| task.send(attribute)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  # ransackable_attributesをオーバーライドして、検索対象のparamsを指定
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  # ransackable_associationsをオーバーライドして、検索条件に意図しない関連を含めないようにする
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
