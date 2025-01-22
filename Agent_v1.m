open_system("PB2M_001_003_RL");
obsInfo = rlNumericSpec([(forecast*2 + 5), 1]);
actInfo = rlNumericSpec([1 1],"UpperLimit",1,"LowerLimit",0);
env = rlSimulinkEnv("PB2M_001_003_RL","PB2M_001_003_RL/ctrl/RL_Agent",obsInfo,actInfo);
optopts = rlOptimizerOptions("LearnRate",1e-3);
opts = rlSACAgentOptions("SampleTime",1,"ActorOptimizerOptions",optopts,"CriticOptimizerOptions",optopts,"ExperienceBufferLength",1e6);%,"EntropyWeightOptions",EntropyWeightOptions("EntropyWeight",100, "TargetEntropy",-1));
agent = rlSACAgent(obsInfo,actInfo);
trainopts = rlTrainingOptions("MaxStepsPerEpisode",10,"MaxEpisodes",1,"StopTrainingCriteria","None");
info = train(agent,env,trainopts);
if smlt && vanilla == 0
    simopts = rlSimulationOptions("MaxSteps",10);
    info_sim = sim(agent,env,simopts);
    observations = info_sim.Observation;
    actions = squeeze(info_sim.Action.act1.Data);
    rewards = info_sim.Reward.Data;
    cumulative_rewards = cumsum(rewards);
    plot(actions);
    xlabel('Time Step');
    ylabel('Action');
    title('Actions Over Time');
    plot(cumulative_rewards);
    xlabel('Time Step');
    ylabel('Cumulative Reward');
    title('Cumulative Reward Over Time');
end


