function next=getNextVec(cur, obj)
	objc=[obj(1)*cos(obj(2)) obj(1)*sin(obj(2))];
	len=1024;
	next=[0, 0];
	for biasv=-.1:.1:.1
		for biasw=-.1:.1:.1
			vec=cur+[biasv, biasw];
			vecc=[vec(1)*cos(vec(2)) vec(1)*sin(vec(2))];
			tmp=objc-vecc;
			len_squr=sum(tmp.*tmp);
			if (len_squr < len)
				len=len_squr;
				next=vec;
			end
		end
	end