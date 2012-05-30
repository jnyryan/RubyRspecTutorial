require 'spec_helper'

describe "Library Object" do
  before :all do
    lib_arr = [
        Book.new("Dev for Dummies","John Ryan",:development),
        Book.new("Design for Dummies","John Ryan",:design),
        Book.new("Dev for losers","Joe Ryan",:development),
        Book.new("More Dev on Dev","Fred Ryan",:development),
        Book.new("Smart Design for losers","Bill Ryan",:design),
    ]

      File.open "books.yml", "w" do |f|
      f.write YAML::dump lib_arr
      end
    end

    before :each do
      @lib = Library.new "books.yml"
    end

    describe "#new" do
      context "with no parameters" do
        it "has no books" do
          lib=Library.new
          lib.books.length.should == 0
        end

        context "with yaml file parameter" do
          it "has 5 books" do
            @lib.books.length.should == 5
          end
        end
      end
    end

  it "returns all books in a give category" do
    @lib.get_books_in_category(:development).length.should == 3
  end

  it "accepts new books" do
    @lib.add_book (Book.new "New Design Methods","Bill Berry",:design)
    @lib.get_book("New Design Methods").should be_an_instance_of Book
  end

  it "saves the library" do
    books = @lib.books.map{|book| book.title}
    @lib.save "new_library.yml"
    lib2 = Library.new "new_library.yml"
    books2 = lib2.books.map {|book| book.title}
    books.should eql books2
  end

end
