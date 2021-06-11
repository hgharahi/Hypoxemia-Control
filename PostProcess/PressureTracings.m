close all
for i = 1:6
    for j = 1:6
        figure;
        plot(Control{i}.Testset(j).t,Control{i}.Testset(j).AoP);
        hold on;
        plot(Control{i}.Testset(j).t,Control{i}.Testset(j).PLV);
        title(['Control ',num2str(i),' CPPcase ',num2str(j)]);
    end
end