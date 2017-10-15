<template>
  <div class="topoPanelWrapper">
    <div class="toolbarPanel">
      <topo-toolbar v-bind:toolbarItems="toolbarItems"
                    v-on:onToolbarItemClick="onToolbarItemClick"></topo-toolbar>
    </div>
    <marvel-dialog theme="dark" :showDialog="showDialog4CreateFiber"
                   title="创建光纤" width="500" height="300"
                   v-on:onClickDialogClose="onClickDialog4CreateFiberClose">
      <div slot="dialogCont">
        <marvel-search-with-drop-down placeholder="请输入关键字..." @search="search4SrcNe"
                                  :selectItems="selectItems4CreateFiber"></marvel-search-with-drop-down>
        <marvel-grid :titles="titles4CreateFiber" :rows="rows4CreateFiber"></marvel-grid>
        <div>
          <div>端口</div>
          <div v-for="portItem in portItems">
            <marvel-radio-box ref=portItem.ref id=portItem.id group="group4Src"
                              label=portItem.label showLabel="true"></marvel-radio-box>
          </div>
        </div>
      </div>
      <div slot="dialogFoot"></div>
    </marvel-dialog>
    <div class="topoPanelContent">
      <topo-center-area ref="ref4TopoCenterArea"
                        v-bind:theme="theme"
                        v-bind:id="id4Topo"></topo-center-area>
      <topo-left-area ref="ref4LeftArea"
                      v-if="showLeftAreaEx"
                      v-on:onTreeNodeClick="onTreeNodeClick"></topo-left-area>
      <topo-right-area ref="ref4RightArea"
                       v-if="showRightAreaEx"></topo-right-area>
    </div>
  </div>
</template>

<script>
  import TopoToolbar from "@/components/0.common/0.2.topo/TopoToolbar";
  import TopoLeftArea from "@/components/0.common/0.2.topo/TopoLeftArea";
  import TopoCenterArea from "@/components/0.common/0.2.topo/TopoCenterArea";
  import TopoRightArea from "@/components/0.common/0.2.topo/TopoRightArea";
  import {MarvelDialog,MarvelSearchWithDropDown,MarvelGrid,MarvelRadioBox} from "marvel-fui2";

  export default {
    components: {
      MarvelRadioBox,
      MarvelGrid,
      MarvelSearchWithDropDown,
      MarvelDialog,
      TopoRightArea,
      TopoCenterArea,
      TopoLeftArea,
      TopoToolbar
    },
    name: "TopoPanel",
    props: ["theme", "toolbarItems", "id4Topo", "showLeftArea", "showRightArea"],
    data: function () {
      return {
        //#region createFiber
        showDialog4CreateFiber: false,
        titles4CreateFiber: [{
          label: "",
          width: "5%"
        }, {
          label: "子网名称",
          width: "25%"
        }, {
          label: "网元名称",
          width: "25%"
        }, {
          label: "单板信息",
          width: "45%"
        }],
        rows4CreateFiber: [],
        selectItems4CreateFiber:[{
          label: "子网名称",
          selected: true
        },{
          label: "网元名称",
          selected: false
        },{
          label: "单板信息",
          selected: false
        }],
        portItems:[],
        //#endregion
      }
    },
    methods: {
      //#region inner
      onClickDialog4CreateFiberClose: function(){
          this.showDialog4CreateFiber=false;
      },
      search4SrcNe: function(searchKey, strSearchVal){
          console.log(searchKey);
          console.log(strSearchVal);
      },
      //#endregion
      //#region callback
      onTreeNodeClick: function (oTreeNode) {
        this.$emit("onTreeNodeClick", oTreeNode);
      },
      onToolbarItemClick: function(oToolbarItem){
        this.$emit("onToolbarItemClick", oToolbarItem);
      },
      //#endregion
      //#region 3rd
      setData4LeftArea: function (oData4LeftArea) {
        this.$refs.ref4LeftArea.setData4LeftArea(oData4LeftArea);
      },
      setData4RightArea: function (oData4RightArea) {
        this.$refs.ref4RightArea.setData4RightArea(oData4RightArea);
      },
      selectNe: function (strNeId) {
        this.$refs.ref4TopoCenterArea.unSelectAll();
        this.$refs.ref4TopoCenterArea.selectNodesById([strNeId]);
      },
      selectLink: function (strLinkId) {
        this.$refs.ref4TopoCenterArea.unSelectAll();
        this.$refs.ref4TopoCenterArea.selectLinksById([strLinkId]);
      },
      initTopo: function (oAfterCallBack) {
        this.$refs.ref4TopoCenterArea.init(oAfterCallBack);
      },
      drawTopo: function (oTopoData) {
        this.$refs.ref4TopoCenterArea.draw(oTopoData);
      },
      updateTopo: function (oTopoData) {
        this.$refs.ref4TopoCenterArea.updateTopo(oTopoData);
//        console.log("updateTopo");
      },
      setShowDialog4CreateFiber: function (isShow){
          this.showDialog4CreateFiber=isShow;
      },
      setGrid4CreateFiber: function(oRows4CreateFiber) {
          this.rows4CreateFiber=oRows4CreateFiber;
      }
      //#endregion
    },
    computed: {
      showLeftAreaEx: function(){
          if(this.showLeftArea === false){
              return false;
          }
          else{
              return true;
          }
      },
      showRightAreaEx: function(){
        if(this.showRightArea === false){
          return false;
        }
        else{
          return true;
        }
      },
    }
  }
</script>

<style scoped>
  .topoPanelWrapper {
    width: 100%;
    height: 100%;
  }

  .toolbarPanel {
    width: 100%;
    height: 30px;
  }

  .topoPanelContent {
    width: 100%;
    height: calc(100% - 30px);
    position: relative;
  }
</style>
