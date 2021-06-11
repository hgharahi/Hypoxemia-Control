close all
for i = [1:number_of_dobs]
    for j = 1:6
        figure;
        plot(Dob{i}.Testset(j).t,Dob{i}.Testset(j).AoP);
        hold on;
        plot(Dob{i}.Testset(j).t,Dob{i}.Testset(j).PLV);
        title(['Dob ',num2str(i),' CPPcase ',num2str(j)]);
    end
end