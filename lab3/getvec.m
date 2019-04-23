%{
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
%}
function vec=getvec(x, y, k1, k2, k3, k4) % x: a turple
	% in b, c:
    if (x<0)
        x_=x+1;
        y_=y;
        vec=[.5 sign(y_)];
        %vec=[-sign(x_*y_)*k2/x_ -y_]; %����������
        disp('in x<0');
        % in d
    elseif (y>3 || y<-3)
        vec=[k3 0];
        disp('in y>3 || y<-3');
	% in a
    elseif (x>0 && x<4)
        vec=k1*([-1 0] - [x y]);
        disp('in x<4');
    % in e
    else
        vec=k4*([.8 0] - [x y]);
        disp('in e');
    end
    disp(vec);
end
