function A = obj_fun_all(b, fact, Testset, t_final, t_off, beta, C)

Params = ModelParameters_ParamEst(b , fact, beta);

%% Pressure input simulation: Initialization and solution to ODE
% With the case of coronary perfusion of 100 mmHg, we determine the
% baseline. The flow waveform from this simulation is then used for
% modeling the Pzf in other coronary pressure cases.
Xo_myo = [Testset.Ppump(1) 1 10 10 35 35 600 60 5]'; % for 2713 Resting

Testset.dPLVdt = TwoPtDeriv(Testset.PLV,Testset.dt);

[t,X] = ode15s(@dXdT_myocardium,[0 t_off],Xo_myo,[], Testset, Params);


Result_ON = PostProcessing(t,X,Testset, Params);
Result_ON.t = t;


t_idx = t>t_off-2*Testset.T & t<=t_off;
Dt = diff(Result_ON.t);

Qendo = Result_ON.Q13(t>t_off-2*Testset.T & t<=t_off);
Qendo = sum(Result_ON.Q13(t_idx).*Dt(t_idx(2:end)))/(2*Testset.T);
% Qendo = mean(Qendo);

Qepi = Result_ON.Q11(t>t_off-2*Testset.T & t<t_off);
Qepi = sum(Result_ON.Q11(t_idx).*Dt(t_idx(2:end)))/(2*Testset.T);
% Qepi = mean(Qepi);


ENDOEPI = Qendo/Qepi;
%% Flow input simulation
% The input flow from the baseline simulation is used as the input into
% another simulation. Vasoconstriction/dilation leads to increased input
% pressures. We try to match the experimental CPP's with the right factors.

InFlow = Flow(t,X(:,2),t_off, t_final); %Using the results from the baseline simulation.

% Q1   = smoothdata(InFlow.Q,'gaussian','smoothingfactor',0.15);
% [~, locs] = findpeaks(Q1);

Qmean = Result_ON.Q_PA(t>t_off-2*Testset.T & t<=t_off);
Qmean = 60*sum(Result_ON.Q_PA(t_idx).*Dt(t_idx(2:end)))/(2*Testset.T);
% Qmean = 60*mean(InFlow.Q(t>t_off-2*Testset.T & t<t_off));


Xo_myo = [X(end,1),X(end,3:end)];

[t1,X1] = ode15s(@dXdT_myocardium_Qin,[t_off t_final],Xo_myo,[], Testset, InFlow, Params);

%% Calculate variables and cost function

CPP_exp = interp1(Testset.t,Testset.CPP,[t; t1]);

CPP_sim = [X(:,1); X1(:,1)];
t_sim = [t;t1];

A = 2*abs((Testset.FlowAverage - Qmean) / Testset.FlowAverage) + ...
    1.5*sqrt(sum((CPP_exp(t_sim>2) - CPP_sim(t_sim>2)).^2)./sum(CPP_exp(t_sim>1).^2)) + ...
    C*abs(ENDOEPI-1.2);














