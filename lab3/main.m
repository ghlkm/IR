%{

vector filed:

				d
		 D________________________E
		|                        |
		|___________________     |
		A				   H|    |
							|    |
							|    |     e
							|    |					__
c	O'b	O		a			|    |                  |T|
							|    |					
							|    |
							|    |
		B _________________G|    |
		|				         |
		|________________________|
		C                         F
		
		a: 引力场引至O'
		b: O点出发的排斥场
		c：O的排斥场 与 T 的引力场组合， T弱
		d: O的排斥场 与 T
		e: T的引力场
		
		
		O (0, 0)
		O'(-10, 0)   alia X
		A  (0, 20)
		B  (0, -20)
		C  (0, -30)
		D  (0, 30)
		E  (50, 30)
		F  (50, -30)
		H  (40, 20)
		G  (40, -20)
		T  (80, 0)
		
		场a: k1 * [(-10, 0) - (x, y)]  
		场b, c:
			x'y' >0
				k2=x'y',    #     x', y' = (x, y) - O'
		    x'y' <0
				-k2=x'y'
		d: (k3, 0)
		e: k4*(T-(x, y))
		
		初始化
		while
			获得位置， 速度状态
			计算加速度场
			9个向量中找到最近的向量next
			发送action
%}
%{
初始化要初始化什么

1. 地图障碍物的轮廓
2. 小车的位置， 速度
3. 目标的位置

%}
rosshutdown
O=[0 0];
X=[-10 0];
A=[0 20];
B=[0 -20];
C=[0 -30];
D=[0 30];
E=[50, 30];
F=[50, -30];
H=[40, 20];
G=[40, -20];
T=[80, 0];
v_unit=0.1;
w_unit=0.1;
cur_pos=[0 0];
next=[0 0];
setenv('ROS_MASTER_URI', 'http://192.168.157.128:11311');
rosinit
while (0==0)
    odomData=receive(rossubscriber('/odom'),3);
    stateData=receive(rossubscriber('/gazebo/model_states'));
    cur_pos=odomData.Pose.Pose.Position;
    disp('curpos');
    disp(cur_pos);
    cur_v=stateData.Twist.Linear;
    obj=getvec(cur_pos.X, cur_pos.Y, 1, 1,1,1);
    disp('objv');
    disp(obj)
    tmp=[(cur_v.X*cur_v.X+cur_v.Y*cur_v.Y)^.5 atan2(cur_v.X, cur_v.Y)];
    tmp2=[sum(obj.*obj)^.5 atan2(obj(1), obj(2))];
    next=getNextVec(tmp, tmp2);
    %next(1)=sum(obj.*obj)^.5
    disp('nextv');
    disp(next)
    velpub=rospublisher('cmd_vel');
    velmsg=rosmessage(velpub);
    velmsg.Linear.X=next(1);
    velmsg.Angular.Z=next(2);
    send(velpub, velmsg);
    pause(0.5);
end 
rosshutdown
