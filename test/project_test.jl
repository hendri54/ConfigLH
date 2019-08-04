using ConfigLH.ProjectLH

@testset "projectLH" begin
	println("-----")
	println("Testing projectLH")
    pName = "test";
    @test isdir(ProjectLH.project_dir(2018));
    proj = ProjectLH.Project(pName, pwd(), [pwd()]);
    show(proj);
    
    proj2 = ProjectLH.get_project(pName);
    @test proj2.name == pName;
    project_start(pName)
end
