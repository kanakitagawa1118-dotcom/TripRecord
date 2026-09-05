class Tweet < ApplicationRecord
  belongs_to :user

  has_many :travel_days, dependent: :destroy

  has_many :collaborations, dependent: :destroy

  has_many :collaborators,
           through: :collaborations,
           source: :user

  has_one_attached :thumbnail

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_must_be_after_start_date
  validate :thumbnail_must_be_image
  validate :thumbnail_size

  # そのユーザーが旅行のオーナーか判定
  def owned_by?(target_user)
    user == target_user
  end

  # そのユーザーが旅行を編集できるか判定
  def editable_by?(target_user)
    return false if target_user.nil?

    owned_by?(target_user) ||
      collaborators.exists?(id: target_user.id)
  end

  private

  def end_date_must_be_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(
        :end_date,
        "は旅行開始日以降にしてください"
      )
    end
  end

  def thumbnail_must_be_image
    return unless thumbnail.attached?

    allowed_types = [
      "image/jpeg",
      "image/png",
      "image/webp"
    ]

    unless thumbnail.content_type.in?(allowed_types)
      errors.add(
        :thumbnail,
        "はJPEG・PNG・WebP形式にしてください"
      )
    end
  end

  def thumbnail_size
    return unless thumbnail.attached?

    if thumbnail.blob.byte_size > 10.megabytes
      errors.add(
        :thumbnail,
        "は10MB以下にしてください"
      )
    end
  end
end