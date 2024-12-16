%% Update plot function - Rvk Cardona


function updatePlot(dpqData, slqData, selectedVariable, category, ax)

    cla(ax);
    
    data = [];
    
    switch category
        case 'mentalHealth'
            if strcmp(selectedVariable, 'Feeling Down')
                avgSleepPerFeeling = NaN(1, 4); 
                for feelingValue = 0:3
                    feelingGroup = dpqData(dpqData.FeelingDown == feelingValue, :);
                    sleepGroup = slqData.SleepHrsNight(ismember(slqData.SEQN, feelingGroup.SEQN));
                    avgSleepPerFeeling(feelingValue + 1) = mean(sleepGroup, 'omitnan');
                end
                bar(ax, avgSleepPerFeeling);
                set(ax, 'xtick', 1:4, 'xticklabel', {'Not at all', 'Several days', 'More than half the days', 'Nearly every day'});
                xlabel(ax, 'Feeling Down');
                ylabel(ax, 'Average Sleep Hours');
                title(ax, 'Average Sleep Hours by Feeling Down');
            elseif strcmp(selectedVariable, 'Appetite Issues')
                % Process data for Appetite Issues
                avgSleepPerAppetite = NaN(1, 4); % Array for average sleep hours
                for appetiteValue = 0:3
                    appetiteGroup = dpqData(dpqData.AppetiteIssues == appetiteValue, :);
                    sleepGroup = slqData.SleepHrsNight(ismember(slqData.SEQN, appetiteGroup.SEQN));
                    avgSleepPerAppetite(appetiteValue + 1) = mean(sleepGroup, 'omitnan');
                end
                bar(ax, avgSleepPerAppetite);
                set(ax, 'xtick', 1:4, 'xticklabel', {'Not at all', 'Several days', 'More than half the days', 'Nearly every day'});
                xlabel(ax, 'Appetite Issues');
                ylabel(ax, 'Average Sleep Hours');
                title(ax, 'Average Sleep Hours by Appetite Issues');
            end
    end
end
