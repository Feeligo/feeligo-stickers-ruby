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
    context "with https protocol" do
      it "sets https as the protocol of the loader's URL" do
        js = subject::loader_script_tag protocol: 'https'
        js[/https:\/\//].should_not be_nil
      end
      it "uses stickersapissl.feeligo.com by default" do
        js = subject::loader_script_tag protocol: 'https'
        js[/https:\/\/stickersapissl.feeligo.com/].should_not be_nil
      end
    end
  end


  describe "::replace_sticker_tags" do
    let(:opts){{}}
    context "when the input contains at least one tag" do
      let(:string){"Hello [s:PATH] world"}
      it "does not change the original string, returns a different copy" do
        input = string
        expect(lambda{
          result = Feeligo::Stickers.replace_sticker_tags(input, opts)
          expect(result).not_to eq input
        }).not_to change(input, :to_s)
      end
      context "with multiple tags" do
        let(:string){"Hello [s:PATH1][s:PATH2] world"}
        it "correctly replaces each tag" do
          expect(Feeligo::Stickers.replace_sticker_tags(string, opts)).to eq(
            'Hello <img src="http://stkr.es/PATH1"/><img src="http://stkr.es/PATH2"/> world')
        end
        context "when the tags correspond to different sizes" do
          let(:string){"Hello [s:p3w/1][s:p7s/2][s:p/3][s:s/p3w] world"}
          it "replaces them with 70x70px sticker images by default" do
            expect(Feeligo::Stickers.replace_sticker_tags(string, opts)).to eq(
              'Hello <img src="http://stkr.es/p/1"/><img src="http://stkr.es/p/2"/><img src="http://stkr.es/p/3"/><img src="http://stkr.es/s/p3w"/> world')
          end
        end
      end
    end
    shared_examples "with no tags" do
      it "returns an unchanged copy" do
        result = Feeligo::Stickers.replace_sticker_tags(string, opts)
        expect(result).to eq string
        expect(result).not_to equal string # result !== string (it's a copy)
      end
    end
    context "when the input contains no tags" do
      let(:string){"Hello world"}
      it_behaves_like "with no tags"
    end
    context "when the input contains a tag with no path" do
      let(:string){"Hello [s:] world"}
      it_behaves_like "with no tags"
    end
  end

end
