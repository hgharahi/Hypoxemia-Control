close all
for i = [1:number_of_HD]
    for j = 1:6
        figure;
        plot(HD{i}.Testset(j).t,HD{i}.Testset(j).AoP);
        hold on;
        plot(HD{i}.Testset(j).t,HD{i}.Testset(j).PLV);
        title(['HD ',num2str(i),' CPPcase ',num2str(j)]);
    end
end