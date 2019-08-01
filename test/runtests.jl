using ConfigLH
using Test

@testset "Computer" begin
    currentComp = ConfigLH.current_computer()
    @test currentComp == ConfigLH.ComputerLocal

    ci = ConfigLH.computer_info(currentComp)
    @test ci.runLocal
    @test isdir(ci.baseDir)
    ci = ConfigLH.computer_info()
    @test ci.runLocal

    @test isdir(ConfigLH.docu_dir(currentComp))
    @test isdir(ConfigLH.docu_dir())

    @test ConfigLH.running_local()

    @test isdir(ConfigLH.shared_dir())
    @test isdir(ConfigLH.julia_dir())

    @test isdir(ConfigLH.project_dir(2018))
end


@testset "Directories" begin
	newStr = "remove/this"
	add_to_path!(newStr)
	@test in(newStr, LOAD_PATH)
	remove_from_path!(newStr);
	@test !in(newStr, LOAD_PATH)
	n = length(LOAD_PATH)
	remove_from_path!(newStr);
	@test length(LOAD_PATH) == n
end

# ----------
