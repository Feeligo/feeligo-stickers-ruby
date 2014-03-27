require 'feeligo/stickers'

describe Feeligo::Stickers do
  subject{Feeligo::Stickers}

  describe "::loader_script_tag" do
    shared_examples "it returns a <script> tag" do
      it "returns a string between <script> and </script>" do
        js = subject::loader_script_tag user_id: user_id
        re = /^<script.*?>(.*?)<\/script>$/m
        re.match(js).should_not be_nil
      end
    end
    shared_examples "it includes the user_id" do
      it_behaves_like "it returns a <script> tag"
      it "correctly sets the 6th argument of the closure" do
        js = subject::loader_script_tag user_id: user_id
        args = js.scan(/\((.*?)\)/).last.first.split(',')
        args.length.should eq 6
        args.last.should eq "'#{user_id}'"
      end
    end
    shared_examples "it ignores the user_id" do
      it_behaves_like "it returns a <script> tag"
      it "only passes 5 arguments to the closure" do
        js = subject::loader_script_tag user_id: user_id
        args = js.scan(/\((.*?)\)/).last.first.split(',')
        args.length.should eq 5
      end
    end
    context "with an Integer user_id" do
      let(:user_id){12}
      it_behaves_like "it includes the user_id"
    end
    context "with a String user_id" do
      let(:user_id){'abcd12'}
      it_behaves_like "it includes the user_id"
    end
    context "with a blank String user_id" do
      let(:user_id){''}
      it_behaves_like "it ignores the user_id"
    end
    context "with a nil user_id" do
      let(:user_id){''}
      it_behaves_like "it ignores the user_id"
    end
    context "with a user_id equal to 0" do
      let(:user_id){0}
      it_behaves_like "it ignores the user_id"
    end
    context "with a user_id equal to '0'" do
      let(:user_id){0}
      it_behaves_like "it ignores the user_id"
    end
  end

end
