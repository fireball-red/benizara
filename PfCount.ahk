;*****************************************************************************
;  �����x�^�C�}�[�֐��Q (PfCount.ahk)
;
;	�O���[�o���ϐ� : TickFrequency, Ticks0
;	�g�����FPf_Init()���Ăяo�����̂��� Pf_Count() ���Ăяo��
;   AutoHotkey:     L 1.1.29.01
;    Language:       Japanease
;    Platform:       NT�n
;    Author:         Kenichiro Ayaki
;*****************************************************************************


;-----------------------------------------------------------
; Performance Counter�̏�����
;   �߂�l          1:���� / 0:���s
;-----------------------------------------------------------
Pf_Init()
{
	global TickFrequency, global Ticks0
	TickFrequency := 0, Ticks0 := 0
	ret := DllCall("QueryPerformanceFrequency","Int64*",TickFrequency) ;obtain ticks per second
	if(ret)
	{
		ret := DllCall("QueryPerformanceCounter","Int64*",Ticks0) ;obtain the performance counter value
	}
	
	if(!ret)
	{
		TickFrequency := 0, Ticks0 := 0
	}
	return ret
}
;-----------------------------------------------------------
; Performance Counter�ɂ��N����̌o�ߎ��ԁi�~���b�j
;   �߂�l	0�ȊO �N����̌o�ߎ��� / 0:���s
;-----------------------------------------------------------
Pf_Count()
{
	global TickFrequency, global Ticks0
	if(TickFrequency = 0)
	{
		return A_Tickcount
	}

	Ticks1 := 0
	If !DllCall("QueryPerformanceCounter","Int64*",Ticks1) ;obtain the performance counter value
	{
		return 0
	}
	myTick := (Ticks1 - Ticks0)*1000.0/TickFrequency
	iTick := Floor(myTick)
	return iTick
}
