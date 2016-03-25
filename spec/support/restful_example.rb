RSpec.shared_examples "a rssources controller" do |options|
  before { @request.env['devise.mapping'] = Devise.mappings[:user]}
  options ||= {}

  collection_actions = options[:collection] || [:index, :new, :create]
  member_actions = options[:member] || [:new, :show, :edit, :update, :destroy]
  all_actions = collection_actions + member_actions
  all_actions = [options[:only]].flattent if options[:only]
  all_actions -= [options[:except]].flattent if options[:except]

  collection_actions &= all_actions
  member_actions     &= all_actions

  let(:base_params) { Hash.new }

  if collection_actions.include?(:index)
    describe "GET #index" do
      before { get :index, base_params }
      it { should respond_with(:success) }
    end
  end

  if collection_actions.include?(:new)
    describe "GET #new" do
      before { get :new, base_params }
      it { should respond_with(:success) }
    end
  end

  if collection_actions.include?(:create)
    before { self.class.instance_eval { let(:resource_name) { resource.to_model.class.model_name.param_key } } if respond_to?(:resource) }
    let(:valid_attributes) { Hash.new }

    describe "POST #create" do
      context "with valid attributes" do
        before { post :create, base_params.merge(resource => valid_attributes) }
        it { should respond_with(:redirect) }
      end

      context "with invalid attribtues" do
        around { |example| example.run if respond_to?(:invalid_attributes) }
        before { post :create, base_params.merge(resource => invalid_attributes) }

        it {should respond_with(:success) if respond_to?(:invalid_attributes)
            should render_template(:new) if respond_to?(:invalid_attributes) }
      end
    end
  end

  if member_actions.any?
    let(:member_params) { base_params.merge(id: resource.to_param) }
    let(:resource_name) { resource.to_model.class.model_name.param_key }

    if member_actions.include?(:show)
      describe
    end

    if member_actions.include?(:edit)
      let(:edit_params) { member_params }

      describe "GET #edit" do
        before {get :edit, id: edit_params}
        it { should render_template(:edit) }
        it { should respond_with(:success) }
      end
    end

    if member_actions.include?(:update)
      let(:update_param) { member_params }
      let(:valid_attributes) { Hash.new }

      describe "PUT #update" do
        let(:person) { create :person, user: user }

        context "with valid attribtues" do
          before { put :update, update_param.merge(resource_name => valid_attributes) }
          it { should respond_with(:success) }
        end

        context "with invalid attributes" do
          around { |example| example.run if respond_to?(:invalid_attributes) }
          before { put :update, update_param.merge(resource_name => invalid_attributes) }

          it { should render_template(:edit) if respond_to?(:invalid_attributes)
               should respond_with(:success) if respond_to?(:invalid_attributes) }
        end
      end
    end

    if member_actions.include?(:destroy)
      let(:destroy_param) { member_params }
      describe "DELETE #destroy" do
        before { delete :destroy, destroy_param }
        it { should respond_with(:redirect)}
      end
    end
  end
end