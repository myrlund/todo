class TasksController < ApplicationController
  
  filter_resource_access
  
  before_filter :load_list
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html { redirect_to @list }
      format.xml  { render :xml => @tasks }
      format.json { render :json => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html { redirect_to(@task.list) }
      format.xml  { render :xml => @task }
      format.json { render :json => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
      format.json  { render :json => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(list_path(@task.list, :add => ""), :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
        format.json { render :json => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to([@list, @task], :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  def toggle_done
    @task = Task.find(params[:id])
    @task.toggle_done
    @task.save
    
    respond_to do |format|
      format.html { redirect_to(@task.list, :notice => "#{@task} is now #{@task.status}.") }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  private
  
  def load_list
    @list = List.find(params[:list_id])
  end
  
end
