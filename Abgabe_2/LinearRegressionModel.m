classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            for i = 1:2:nargin
                if strcmp(varargin{i},'Data')
                    obj.trainingData = varargin{i+1};
                elseif strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i+1}; 
                end
            end
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J
            J = (sum((obj.hypothesis() - obj.trainingData.commandVar).^2))/(2 * m);
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code
            hValue = obj.theta(1) + obj.theta(2) * X(:,2);
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            [X,Y] = meshgrid(theta0_vals, theta1_vals);
            Cost = zeros(100);
            for i = 1:100
                for j = 1:100
                    obj.setTheta(theta0_vals(j), theta1_vals(i))
                    Cost(i, j) = obj.costFunction();
                end
            end
            contour(X, Y, Cost)
            xlabel('\theta_{0}');
            ylabel('\theta_{1}');
            xticks(50:10:150);
            hold on;
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'MarkerSize',10, 'LineWidth',2)

            % Optional annotation for theta Optimum (If should be shown
            % without marking the point)
            %text = strcat('(', num2str(obj.thetaOptimum(1)), '; ', num2str(obj.thetaOptimum(2)), ')');
            %annotation('textbox', [.625, .25, .1 .1], 'String', text,'FitBoxToText', 'on')
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);

            Cost = zeros(100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label
            [X,Y] = meshgrid(theta0_vals, theta1_vals);
            for i = 1:100
                for j = 1:100
                    obj.setTheta(theta0_vals(j), theta1_vals(i))
                    Cost(i, j) = obj.costFunction();
                end
            end
            surf(X, Y, Cost)
            xlabel('\theta_{0}');
            ylabel('\theta_{1}');
            
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           hold on;
           
           % ========= YOUR CODE HERE =========
           % add the final trained model plot to the figure ('b-')
           % update the legend

           plot(obj.trainingData.feature, obj.hypothesis(),'b-')
           grid on;
           legend('Training Data', 'Linear Regression Model')
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


