cs = [0.1, 0.5, 1, 5];

cols = [
    0.00 0.00 0.80  % Dark Blue
    0.00 0.45 1.00  % Blue
    0.00 0.70 0.70  % Cyan
    0.00 0.60 0.00  % Green
    0.90 0.50 0.00  % Orange
    0.80 0.00 0.00  % Red
    0.50 0.00 0.50  % Purple
    ];


T = linspace(0, 4, 330);
dT = max(T)/max(size(T));

%rng('default');

init = [2, 1, 0.5, 0, -0.5, -1, -2]


for c_index = 1:4
    c = cs(c_index)
    f = @(x)(x-x.^3);
    g = @(x)(c);
    subplot(2, 2, c_index)
    hold on
    for i = 1:length(init)
        X_plus = zeros(size(T));
        X_minus = zeros(size(T));
        X_plus(1) = init(i);
        X_minus(1) = init(i);

        X_t_plus = X_plus(1);
        X_t_minus = X_minus(1);
        for t = 2:max(size(T))
            X_t_plus = X_t_plus + f(X_t_plus)*dT + g(X_t_plus)*sqrt(dT)*randn(1);
            X_plus(t) = X_t_plus;
            X_t_minus = X_t_minus + f(X_t_minus)*(-dT) + g(X_t_minus)*sqrt(dT)*randn(1);
            X_minus(t) = X_t_minus;
        end
        X1 = horzcat(flip(X_minus(2:end)), X_plus);
        T1 = horzcat(flip(-T(2:end)), T);
        plot(T1, X1, "LineWidth",1,"Color",cols(i, :))
    end
    ax = gca;
    ax.YAxisLocation = 'origin';
    ylim([-3, 3])
    xlim([-4, 4])
    title("Solution for c = " + c)
    set(gca,'fontsize', 24);
end


%legend("$X(0)=2$","$X(0)=1$", "$X(0)=\frac{1}{2}$", "$X(0)=0$","$X(0)=-\frac{1}{2}$", "$X(0)=-1$", "$X(0)=-2$", "Interpreter", "latex", 'NumColumns', 1)