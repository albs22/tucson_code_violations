class ViolationsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :destroy, :manage]

  def index
    @violations = Violation.paginate(page: params[:page], :per_page => 20)
    @violations = @violations.where(:approved => 't')
    if params[:sort] == 'open'
      @violations = @violations.where(:status => 'open')
    end
    if params[:sort] == 'closed'
      @violations = @violations.where(:status => 'closed')
    end
  end
  
  def show
    #only show not approved messes to admins
    @violation = Violation.find(params[:id])

    if @violation.approved? || signed_in_admin?
       respond_to do |format|
         format.html # show.htmb
       end
    else
      redirect_to root_path
    end
  end

  def new
    @violation = Violation.new
    
    respond_to do |format|
      format.html
    end
  end
  
  #GET /violations/1/edit
  def edit
    @violation = Violation.find(params[:id])
  end

  # POST /vioaltions
  def create
    @violation = Violation.new(params[:violation])
#    @violation.date_entered = DateTime.now 
#   respond_to do |format|
      puts "New Mess Created"
      if @violation.save
        flash[:success] = "Violation Submitted!"
  # redirect_to :action=>'show', :id => @violation.id #@violation, notice: 'Violation Created.'
        puts "Send Approval Email"
        MessMailer.approval_email(@violation).deliver
              puts "New Mess Created"
        redirect_to root_path
      else
         redirect_to :action => "new"
      end
#   end
  end

  def approve
    @violation = Violation.find(params[:id])
    @violation.approved = true
    @violation.save
    logger.info "Approve Method"
    redirect_to root_path
  end
  
  #PUT /violations/1
  def update
    @violation = Violation.find(params[:id])
   
    if !params[:update_type].present? 
      if @violation.update_attributes(params[:violation])
       flash[:success] = "Mess updated"
       redirect_to root_path
      else
        flash[:error] = "Could not update Mess"
        render action: 'edit'
      end
   else
     if params[:update_type] = "approve"
       @violation.approved = true
       if @violation.save 
         flash[:success] = "Mess approved - " + params[:update_type]
       else
         flash[:error] = "Could not approve mess"
       end
       redirect_to manage_path
     end    
   end
    
  end
  
  def destroy
    @violation = Violation.find(params[:id])
    @violation.destroy
 
    redirect_to violations_url
  end

  def manage

    @violations = Violation.paginate(page: params[:page], :per_page => 10)

    @violations = @violations.where(:approved => 'f')
       
  end

  def approve
     @violation = Violation.find(params[:id])
     @violation.approved = true
     @violation.save    
     redirect_to manage_path
    
  end


  private

    def signed_in_user
      redirect_to root_path unless signed_in?
    end
        

end
