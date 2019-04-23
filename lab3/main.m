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
		
		a: ����������O'
		b: O��������ųⳡ
		c��O���ųⳡ �� T ����������ϣ� T��
		d: O���ųⳡ �� T
		e: T��������
		
		
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
		
		��a: k1 * [(-10, 0) - (x, y)]  
		��b, c:
			x'y' >0
				k2=x'y',    #     x', y' = (x, y) - O'
		    x'y' <0
				-k2=x'y'
		d: (k3, 0)
		e: k4*(T-(x, y))
		
		��ʼ��
		while
			���λ�ã� �ٶ�״̬
			������ٶȳ�
			9���������ҵ����������next
			����action
%}
%{
��ʼ��Ҫ��ʼ��ʲô

1. ��ͼ�ϰ��������
2. С����λ�ã� �ٶ�
3. Ŀ���λ��

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
