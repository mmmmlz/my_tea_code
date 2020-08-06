#!/bin/sh

PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P) # 这一行命令可以得到 run.sh 所在目录
ls -l $PWD
mkdir ~/.pip/
cat > ~/.pip/pip.conf << EOF
[global]
index-url = http://jfrog.cloud.qiyi.domain/api/pypi/pypi/simple
trusted-host = jfrog.cloud.qiyi.domain
extra-index-url = http://jfrog.cloud.qiyi.domain/api/pypi/iqiyi-pypi-mesos/simple
EOF
#*************************************************************************************#


#**************************************添加conda源**************************************#
cat >> /root/.condarc << EOF
channels:
    - http://jarvis-conda-mirror.qiyi.virtual/mirrors.ustc.edu.cn/anaconda/pkgs/main/linux-64/
    - http://jarvis-conda-mirror.qiyi.virtual/mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/linux-64/
    - http://jarvis-conda-mirror.qiyi.virtual/conda.anaconda.org/caffe2/linux-64/
    - http://jarvis-conda-mirror.qiyi.virtual/conda.anaconda.org/intel/linux-64/
    - http://jarvis-conda-mirror.qiyi.virtual/conda.anaconda.org/pytorch/linux-64/
show_channel_urls: true
auto_update_conda: false
EOF

##
export http_proxy=http://jarvis:jarvis-root@10.191.67.135:3128/
export https_proxy=http://jarvis:jarvis-root@10.191.67.135:3128/
cat /etc/os-release #输出jarvis的系统
apt-get update && apt-get install -y --no-install-recommends apt-utils

apt-get update
#pip install tensorboardX
#ls ${DATA_DIR}
#pt-get install -y zip
#mkdir datasets
ls
pip install tensorboardX
#cp -r ${DATA_DIR}/my-dataset_frame datasets


#ls ${DATA_DIR}
#unzip datasets/my_dataset_frame.zip -d datasets
CUDA_VISIBLE_DEVICES=0,1 python main.py my-dataset RGB \
     --output_dir ${OUTPUT_DIR} --arch tea50 --num_segments 8 --gpus 0 1 \
     --gd 20 --lr 0.02 --lr_steps 30 40 45 --epochs 50 \
     --batch-size 16 -j 16 --dropout 0.5 --consensus_type=avg --eval-freq=1 \
     --experiment_name=TEA --shift \
     --shift_div=8 --shift_place=blockres --npb

#CUDA_VISIBLE_DEVICES=0,1 python main.py my-dataset RGB \
    # --arch tea50 --num_segments 3 --gpus 0 1 \
    # --gd 20 --lr 0.02 --lr_steps 30 40 45 --epochs 50 \
    # --batch-size 16  -j 16 --dropout 0.5 --consensus_type=avg --eval-freq=1 \
    # --experiment_name=TEA --shift \
    # --shift_div=8 --shift_place=blockres --npb
