class Batch::DataReset
    def self.data_reset
        Book.delete_all
        p "投稿は全て削除しました。"
    end
end
