pragma solidity >=0.4.22 <0.9.0;

contract Reputation {
    // 社交网络中实体发送的信息
    struct Message {
        string ipfsHash;
        string sendTime;
    }
    // 社交网络中一个实体
    struct member {
        // 实体的地址
        address memberAddress;
        // 发送信息的顺序
        uint256 numberOfMessage;
        // 信誉值
        int256 reputationValue;
        // 实体对应的信息
        Message[] messageOfMember;
        // mapping(uint=>Message) messageOfMember;
    }

    // 检查该地址是否已经注册为实体
    mapping(address => bool) members;
    // 一个地址对应一个实体
    mapping(address => member) memberMapping;

    // 一个实体对应一个消息序列
    // mapping(address=>Message[]) messageOfMember;

    // 所有注册的实体
    address[] memberArray;

    // 注册实体,返回数组当中的序号
    function addMember(address tempAddress) public {
        // 检查实体是否被注册
        require(members[tempAddress] == false, "the address was registered");

        // 构造方法
        member storage newMember = memberMapping[tempAddress];
        newMember.memberAddress = tempAddress;
        newMember.numberOfMessage = 0;
        newMember.reputationValue = 100;

        memberArray.push(tempAddress);

        // 标记该地址已经注册
        members[msg.sender] = true;
    }

    function addMessage(
        address memberAddress,
        string memory ipfsNewHash,
        string memory tempTime
    ) public {
        // 判断地址是否已经注册
        require(
            members[memberAddress] == true,
            "the memberAddress is not registered"
        );

        // 取出信息的下标
        uint256 index = memberMapping[memberAddress].numberOfMessage;

        // 取出相应的实体
        // 新消息构造方法
        Message storage newMessage = memberMapping[memberAddress]
            .messageOfMember[index];
        newMessage.ipfsHash = ipfsNewHash;
        newMessage.sendTime = tempTime;

        // 消息数加1
        memberMapping[memberAddress].numberOfMessage += 1;
    }

    // 返回一个社交网络中的实体
    function getmember(address memberAddress)
        public
        view
        returns (member memory)
    {
        member memory tempmember = memberMapping[memberAddress];
        return tempmember;
    }

    // 返回一个实体发送的所有信息
    function getAllMessage(address memberAddress)
        public
        view
        returns (Message[] memory)
    {
        return memberMapping[memberAddress].messageOfMember;
    }

    // 返回一个实体发送的某一条信息
    function getMessage(address memberAddress, uint256 indexMessage)
        public
        view
        returns (Message memory)
    {
        return memberMapping[memberAddress].messageOfMember[indexMessage];
    }

    // 返回某一实体的信誉值
    function getmemberOfReputationValue(address memberAddress)
        public
        view
        returns (int256)
    {
        return memberMapping[memberAddress].reputationValue;
    }

    // 返回所有参与的实体
    function getmemberArray() public view returns (address[] memory) {
        return memberArray;
    }

    // 修改信誉积分,信誉积分计算方法
    /**
    引入权重因子进行计算
    情感分析：(-1.1)
        积极：
        消极：
    谣言检测：(-1,1)
        真实：
        虚假：
     */
    function changeReputationValue(
        address memberAddress,
        int256 affectiveValue,
        int256 rumorValue
    ) public {
        memberMapping[memberAddress].reputationValue +=
            affectiveValue +
            rumorValue;
    }
}
