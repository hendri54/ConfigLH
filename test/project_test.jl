using ConfigLH, Test

@testset "projectLH" begin
	println("-----")
	println("Testing projectLH")
    pName = "test";
    @test isdir(ConfigLH.project_dir(2018));
    proj = ConfigLH.Project(pName, pwd(), [pwd()]);
    show(proj);
    
    proj2 = ConfigLH.get_project(pName);
    @test proj2.name == pName;
    project_start(pName)
end

# ------------